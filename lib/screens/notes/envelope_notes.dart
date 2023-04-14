import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/notes/widgets/new_notes.dart';
import 'package:pocket_pal/screens/notes/widgets/notes_card.dart';
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

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final DateFormat formatter = DateFormat('MMM dd');


  late final TextEditingController envelopeNoteName;
  late final TextEditingController envelopeNoteContent;

  List<dynamic> notes = [];

  @override
  void initState(){
    //getEnvelopeData();
    fetchData(
      widget.folder.folderId,
      widget.envelope.envelopeId
    );
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
      userName: auth.getUserDisplayName,
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


Future<void> fetchData(String docName, String envelopeName) async {
  final userUid = PocketPalAuthentication().getUserUID;
  double expenseTotal = 0;
  double incomeTotal = 0;

  FirebaseFirestore.instance
      .collection(userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .doc(envelopeName)
      .snapshots()
      .listen((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          final data = documentSnapshot.data() as Map<String, dynamic>;
         List<dynamic> allNotes = [];

          if (data.containsKey('envelopeTransaction')) {
            final List<dynamic>? envelopeData = data['envelopeNotes'] as List<dynamic>?;
            if (envelopeData != null) {
              for (final Map<String, dynamic> envelopeNotes in envelopeData){
                allNotes.add(envelopeNotes);
              }
            }
          }
          notes = allNotes;
          setState(() {});
        } else {
          print('Document does not exist');
        }
      });
}





Future<void> fetch(String docName, String envelopeName) async {
  final userUid = PocketPalAuthentication().getUserUID;

  FirebaseFirestore.instance
      .collection(userUid)
      .doc(docName)
      .collection("$docName+Envelope")
      .snapshots()
      .listen((QuerySnapshot querySnapshot) {

    if (querySnapshot.docs.isNotEmpty) {
      List<dynamic> allNotes = [];

      querySnapshot.docs.forEach((doc) {

      final data = doc.data() as Map<String, dynamic>;
        if (data.containsKey('envelopeNotes')) {
         final List<dynamic>? envelopeData = data['envelopeNotes'] as List<dynamic>?;
       
         if (envelopeData != null) {
          for (final Map<String, dynamic> notesData in envelopeData){
            allNotes.add(notesData);
          }
         }

        }
      });
        notes = allNotes;
        print(allNotes);
        setState(() {});
    } else {
      print('Collection does not exist or is empty');
    }
    
  }

  );
}
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalette.lightGrey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
      backgroundColor: ColorPalette.rustic,
      foregroundColor: ColorPalette.white,
      elevation: 12,
      onPressed: newNotes,
      child: Icon(FeatherIcons.plus),
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
          top: 20.h,
          left: 14.h,
          right: 14.h
          ),
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).pop();
                      },
                      child: Icon(FeatherIcons.arrowLeft,
                        size: 28,
                        color: ColorPalette.black,),
                    ),
                    SizedBox( width: 10.h,),
                    Text(
                      widget.envelope.envelopeName + " Notes",
                      style: GoogleFonts.poppins(
                        fontSize : 20.sp,
                        color: ColorPalette.black,
                      ),
                    )
                ],
              ),
              SizedBox( height: 15.h,),
               Expanded(
                child: notes.isEmpty
                ? Center(
                  child: Text(
                    "No Notes Yet",
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp
                    ),
                    ),
                )
                : ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index){
                    final noteItem = notes[index];
                    final envelopeNoteContent =
                        noteItem['envelopeNoteContent'] as String;
                    final envelopeNoteName =
                        noteItem['envelopeNoteName'] as String;
                    final envelopeNoteDate = noteItem['envelopeNoteDate'] as Timestamp;
                    final formattedDate = formatter.format(envelopeNoteDate.toDate());
                    
                    return  
                        NotesCard(
                          width: 50,
                          title: envelopeNoteName,
                          content: envelopeNoteContent,
                          dateCreated: formattedDate,
                          userName: auth.getUserDisplayName,
                        );
                  }),
              ),
              
              
            ]
            ),
        ),
      ),
    );
  }
}