import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/envelope_notes_content.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/widgets/dialog_box.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/widgets/new_notes.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/widgets/notes_card.dart';
import 'package:pocket_pal/services/authentication_service.dart';
import 'package:pocket_pal/services/database_service.dart';
import 'package:pocket_pal/utils/envelope_structure_util.dart';
import 'package:pocket_pal/utils/folder_structure_util.dart';
import 'package:pocket_pal/utils/note_structure_util.dart';
import 'package:intl/intl.dart';

class EnvelopeNotesPage extends StatefulWidget {
  final Folder folder;
  final Envelope envelope;

  const EnvelopeNotesPage({
    required this.envelope,
    required this.folder,
    super.key});

  @override
  State<EnvelopeNotesPage> createState() => _EnvelopeNotesPageState();
}

class _EnvelopeNotesPageState extends State<EnvelopeNotesPage> {

  final auth = PocketPalAuthentication();
  final userUid = PocketPalAuthentication().getUserUID;
  final db = PocketPalDatabase();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('MMM dd');
  final DateFormat formatterDateTime = DateFormat('MMMM d h:mm a E');

  late final TextEditingController envelopeNoteName;
  late final TextEditingController envelopeNoteContent;

  List<dynamic> notes = [];

  @override
  void initState(){
    envelopeNoteName = TextEditingController(text : "");
    envelopeNoteContent = TextEditingController(text : "");
    super.initState();
    return; 
  }

   void clearController(){
    envelopeNoteName.clear();
    envelopeNoteContent.clear();
    return;
  }

   @override
  void dispose(){
    super.dispose();
    envelopeNoteName.dispose();
    envelopeNoteContent.dispose();
    return; 
  } 

  void addNotes (String envelopeId) async {
    final data = EnvelopeNotes(
      envelopeNoteContent: envelopeNoteContent.text.trim(),
      envelopeNoteName: envelopeNoteName.text.trim(), 
      envelopeNoteUsername: auth.getUserDisplayName,
      ).toMap();

      PocketPalDatabase().createEnvelopeNotes(
        widget.folder.folderId,
        widget.envelope.envelopeId,
        data
      ); 

      Navigator.of(context).pop();
      clearController();
  }

  void newNotes(){
      showDialog(
        barrierDismissible: false,
        context: context, 
        builder: (BuildContext context){
          return MyNewNotesDialog(
            fieldName: widget.envelope.envelopeId,
            formKey: formKey,
            envelopeNoteName: envelopeNoteName,
            envelopeNoteContent: envelopeNoteContent,
            addNotesFunction: addNotes,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
      backgroundColor: ColorPalette.rustic,
      foregroundColor: ColorPalette.white,
      elevation: 12,
      onPressed: newNotes,
      child: Icon(FeatherIcons.plus),
      ),
      appBar : AppBar(
      backgroundColor:  Colors.grey[50],
        title: Text(
            widget.envelope.envelopeName + " Notes",
            style: GoogleFonts.poppins(
              fontSize : 18.sp,
              color: ColorPalette.black,
            ),
          ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox( height: 5.h,),
             StreamBuilder<Map<String, dynamic>>(
               stream: db.getEnvelopeNotes(
                  widget.folder.folderId, 
                  widget.envelope.envelopeId
                ),
               builder: (context, snapshot) {
              if (!snapshot.hasData || snapshot.data == null) {
                return CircularProgressIndicator();
              }
              final notes = snapshot.data!['notesData'];
              return Expanded(
                  child: notes.isEmpty
                  ? Center(
                    child: Text(
                      "No Notes Yet",
                      style: GoogleFonts.poppins(
                        fontSize: 14.sp
                    ),),
                  )
                  : ListView.builder(
                    itemCount: notes.length,
                    itemBuilder: (context, index){
                      final noteItem = notes[index];
                      final envelopeNoteContent =
                          noteItem['envelopeNoteContent'] as String;
                      final envelopeNoteName =
                          noteItem['envelopeNoteName'] as String;
                      final envelopeNoteUsername = 
                          noteItem['envelopeNoteUsername'] as String;
                      final envelopeNoteDate = noteItem['envelopeNoteDate'] as Timestamp;
                      final formattedDate = formatter.format(envelopeNoteDate.toDate());
                      final formattedDateTime = formatterDateTime.format(envelopeNoteDate.toDate()); //for envelope contents page
                      return  
                          NotesCard(
                            width: 1,
                            title: envelopeNoteName,
                            content: envelopeNoteContent,
                            dateCreated: formattedDate,
                            userName: envelopeNoteUsername,
                            onTap: (){
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EnvelopeContentsPage(
                                    envelopeNoteName: envelopeNoteName,
                                    envelopeNoteContent: envelopeNoteContent,
                                    envelopeNoteUsername: envelopeNoteUsername,
                                    formattedDateTime: formattedDateTime,
                                    deleteNoteFunction: (){
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return MyNoteDialogBoxWidget(
                                              envelopeNoteName: envelopeNoteName,
                                              noteDialogBoxOnTap: () async {
                                                db.deleteEnvelopeNote(
                                                  widget.folder.folderId, 
                                                  widget.envelope.envelopeId,
                                                  index );
                                                ScaffoldMessenger.of(context).showSnackBar(
                                                  const SnackBar(
                                                    content: Text("Successfully Deleted!"),
                                                    duration: Duration(seconds: 1),));
                                                Navigator.pop(context); 
                                                Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(builder: (context) => EnvelopeNotesPage(
                                                    folder: widget.folder,
                                                    envelope: widget.envelope,
                                                  )),
                                                  ModalRoute.withName('/'),
                                                );
                                              }
                                            );
                                          }
                                        );
                                    },
                                  )
                                )
                              );
                            },
                          );
                    }),
                  );
               }
             ),
          ]
          ),
      ),
    );
  }
}