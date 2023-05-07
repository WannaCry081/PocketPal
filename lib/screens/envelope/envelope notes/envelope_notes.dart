import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/add_envelope_note_page.dart';
import 'package:pocket_pal/screens/envelope/envelope%20notes/widgets/notes_card.dart';
import 'package:pocket_pal/services/authentication_service.dart';
import 'package:pocket_pal/services/database_service.dart';
import 'package:pocket_pal/utils/envelope_util.dart';
import 'package:pocket_pal/utils/folder_util.dart';
import 'package:pocket_pal/utils/note_structure_util.dart';
import 'package:intl/intl.dart';
import 'package:pocket_pal/widgets/pocket_pal_dialog_box.dart';

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

  bool isEnabled = true; 

  final auth = PocketPalAuthentication();
  final userUid = PocketPalAuthentication().getUserUID;
  final db = PocketPalDatabase();
  
  String dateTime = "";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('MMM dd');
  final DateFormat formatterDateTime = DateFormat('MMMM d h:mm a E');

  late final TextEditingController envelopeNoteNameController;
  late final TextEditingController envelopeNoteContentController;

  List<dynamic> notes = [];

  @override
  void initState(){
    envelopeNoteNameController = TextEditingController(text : "");
    envelopeNoteContentController = TextEditingController(text : "");
    super.initState();
    return; 
  }

   void clearController(){
    envelopeNoteNameController.clear();
    envelopeNoteContentController.clear();
    return;
  }

   @override
  void dispose(){
    super.dispose();
    envelopeNoteNameController.dispose();
    envelopeNoteContentController.dispose();
    return; 
  } 

  void addNotes (String envelopeId) async {
    final data = EnvelopeNotes(
      envelopeNoteContent: envelopeNoteContentController.text.trim(),
      envelopeNoteName: envelopeNoteNameController.text.trim(), 
      envelopeNoteUsername: auth.getUserDisplayName,
      ).toMap();

      PocketPalDatabase().createEnvelopeNotes(
        widget.folder.folderId,
        widget.envelope.envelopeId,
        data
      ); 
      setState(() {
          isEnabled = false;
        });
      FocusScopeNode currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
      }
      Navigator.of(context).pop();
      clearController();
  }

 void updateNotesFunction(String envelopeId, int index) async {
  final newData = EnvelopeNotes(
    envelopeNoteContent: envelopeNoteContentController.text.trim(),
    envelopeNoteName: envelopeNoteNameController.text.trim(), 
    envelopeNoteUsername: auth.getUserDisplayName,
  ).toMap();

  await PocketPalDatabase().updateEnvelopeNote(
    widget.folder.folderId,
    widget.envelope.envelopeId,
    newData,
    index,
  );
}



  void newNotes(){
    setState((){
      DateTime currentDateTime = DateTime.now();
      dateTime = formatterDateTime.format(currentDateTime);
    });
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => AddEnvelopeNote(
          fieldName: widget.envelope.envelopeId,
          formKey: formKey,
          envelopeNoteUsername: auth.getUserDisplayName,
          envelopeNoteNameController: envelopeNoteNameController,
          envelopeNoteContentController: envelopeNoteContentController,
          addNotesFunction: addNotes,
          dateTime: dateTime,
          isEnabled: true,
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.grey[50],
      floatingActionButton: FloatingActionButton(
      backgroundColor: ColorPalette.crimsonRed,
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
                return const Center(
                  child: CircularProgressIndicator());
              }
              final notes = snapshot.data!['notesData'];
              return Expanded(
                  child: notes.isEmpty
                  ? Center(
                    child: Text(
                      "No notes yet",
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
                      final formattedDateTime = formatterDateTime.format(envelopeNoteDate.toDate()); 
                      final hasNotes = notes.isNotEmpty;

                      late final TextEditingController envelopeNoteNameController = TextEditingController(text: envelopeNoteName);
                      late final TextEditingController envelopeNoteContentController = TextEditingController(text: envelopeNoteContent);
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
                                  builder: (context) => AddEnvelopeNote(
                                    noteIndex: index,
                                    addNotesFunction: addNotes,
                                    updateNoteFunction: (envelopeId) async {
                                    final updatedNote = EnvelopeNotes(
                                      envelopeNoteContent: envelopeNoteContentController.text.trim(),
                                      envelopeNoteName: envelopeNoteNameController.text.trim(),
                                      envelopeNoteUsername: auth.getUserDisplayName,
                                    ).toMap();

                                    await db.updateEnvelopeNote(
                                      widget.folder.folderId,
                                      widget.envelope.envelopeId,
                                      updatedNote,
                                      index,
                                    );
                                  },
                                    isEnabled: true,
                                    showDeleteIcon: hasNotes,
                                    formKey: formKey,
                                    fieldName: widget.envelope.envelopeId,
                                    dateTime: formattedDateTime,
                                    envelopeNoteNameController: envelopeNoteNameController,
                                    envelopeNoteContentController: envelopeNoteContentController,
                                    envelopeNoteUsername: envelopeNoteUsername,
                                    //formattedDateTime: formattedDateTime,
                                    deleteNoteFunction: (){
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (context) {
                                            return PocketPalDialogBox(
                                              pocketPalDialogTitle: "Confirm Deletion",
                                              pocketPalDialogContent: Text("Are you sure you want to delete $envelopeNoteName?"),
                                              pocketPalDialogOption1: "Yes",
                                              pocketPalDialogOption2: "No",
                                              pocketPalDialogOption1OnTap: () => Navigator.of(context).pop(),
                                              pocketPalDialogOption2OnTap: () async {
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