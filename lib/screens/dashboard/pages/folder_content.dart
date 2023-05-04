import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/screens/dashboard/pages/folder_chat_box.dart";
import "package:pocket_pal/services/database_service.dart";

import "package:pocket_pal/screens/dashboard/widgets/bottom_edit_sheet.dart";
import "package:pocket_pal/screens/dashboard/widgets/envelope_widget.dart";
import "package:pocket_pal/screens/envelope/envelope.dart";
import "package:pocket_pal/screens/envelope/widgets/envelope_dialog_box.dart";

import "package:pocket_pal/utils/envelope_structure_util.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class FolderContentPage extends StatefulWidget {
  final Folder folder;

  const FolderContentPage({ 
    Key ? key,
    required this.folder
  }) : super(key : key);

  @override
  State<FolderContentPage> createState() => _FolderContentPageState();
}

class _FolderContentPageState extends State<FolderContentPage> {

  final TextEditingController _envelopeName = TextEditingController(text : "");
  final TextEditingController _envelopeStartingAmount = TextEditingController(text : "");

  @override
  void dispose(){
    super.dispose();
    _envelopeName.dispose();
    _envelopeStartingAmount.dispose();
    return;
  }

  @override 
  Widget build(BuildContext context){

    final db = PocketPalDatabase();

    return Scaffold(
      appBar : AppBar(
        title : titleText(
          "${widget.folder.folderName} Wall",
          titleWeight : FontWeight.w600
        ),
        

        actions: [
          IconButton(
            icon : const Icon(
              FeatherIcons.messageCircle,
              color : Colors.black
            ),
            onPressed: (){
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder : (context) => FolderChatBox(
                    folder : widget.folder

                  )
                )
              );
            },
          )
        ],
      ),

      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorPalette.crimsonRed,
        onPressed: _dashboardAddEnvelope,
        child : Icon(
          Icons.add_rounded, 
          color: ColorPalette.white,
        ),
      ),

      body : _dashboardEnvelopeView(
        db
      )
    );
  }

  void _dashboardAddEnvelope(){
    showDialog(
      context: context,
      builder: (context) {
        return MyEnvelopeDialogBoxWidget(
          controllerName: _envelopeName,
          envelopeAmountcontrollerName: _envelopeStartingAmount,
          dialogBoxHintText: "Untitled Envelope",
          dialogBoxTitle: "Add Envelope",
          dialogBoxErrorMessage: "Please enter a name for your Envelope",
          envelopeAmountHintText: "Starting Amount",
          dialogBoxOnTap: (){
            if (_envelopeName.text.isNotEmpty){
              Envelope envelope = Envelope(
                envelopeName: _envelopeName.text.trim(),
                envelopeStartingAmount: double.parse(_envelopeStartingAmount.text.trim())
              );

              PocketPalDatabase().createEnvelope(
                widget.folder.folderId, 
                envelope.toMap()  
              );

              _envelopeName.clear();
              _envelopeStartingAmount.clear();
              Navigator.of(context).pop();
            }
          },
        );
      }
    );
    return;
  }

  Widget _dashboardEnvelopeView(PocketPalDatabase db){
    return StreamBuilder(
      stream : db.getEnvelope(widget.folder.folderId),
      builder: (context, snapshot){
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child : CircularProgressIndicator()
          );
        } else if (snapshot.hasData){
          
          final data = snapshot.data!;
          final itemList = data.map(
            (e) => MyEnvelopeWidget(
              envelope: e,
              envelopeOnTap: () => 
                _dashboardNavigateToEnvelope(e),
              envelopeOnLongPress: () => 
                _dashboardEditEnvelope(e),

            )
          ).toList();
              
          return GridView.builder(
            itemCount: itemList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index){
              return itemList[index];
            },
          );
                
        } else {
          return Center(
            child: Text(
              "No Available Envelope",
              style : GoogleFonts.poppins(
                fontSize : 14.sp
              )
            ),
          );
        }
      },
    );
  }

  void _dashboardNavigateToEnvelope(Envelope envelope){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => EnvelopeContentPage(
          folder: widget.folder,
          envelope : envelope
        )
      )
    );
    return;
  }

  void _dashboardEditEnvelope(Envelope envelope) {
   
    return;
  }
}