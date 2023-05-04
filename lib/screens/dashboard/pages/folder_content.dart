import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/screens/dashboard/pages/folder_chat_box.dart";

import "package:pocket_pal/screens/dashboard/widgets/envelope_widget.dart";
import "package:pocket_pal/screens/envelope/envelope.dart";
import "package:pocket_pal/screens/envelope/widgets/envelope_dialog_box.dart";

import "package:pocket_pal/utils/folder_structure_util.dart";

import "package:pocket_pal/providers/envelope_provider.dart";


class FolderContentPage extends StatefulWidget {
  
  final Folder folder;
  const FolderContentPage({
    Key ? key,
    required this.folder
  }) : super( key : key );

  @override
  State<FolderContentPage> createState() => _FolderContentPageState();
}


class _FolderContentPageState extends State<FolderContentPage>{

  final TextEditingController _enevelopeAmountController = TextEditingController(text : "");
  final TextEditingController _enevelopeNameController = TextEditingController(text : "");
  @override 
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<EnvelopeProvider>(
      context,
      listen : true
    ).fetchEnvelope(widget.folder.folderId);
    return;
  }

  @override 
  void dispose(){
    super.dispose();
    _enevelopeAmountController.dispose();
    _enevelopeNameController.dispose();
    return;
  }

  @override 
  Widget build(BuildContext context){

    final EnvelopeProvider envelopeProvider = Provider.of<EnvelopeProvider>(context);
    final List<Envelope> envelopeItem = envelopeProvider.getEnvelopeList;
    final int envelopeItemLength = envelopeItem.length;

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
        backgroundColor: ColorPalette.crimsonRed,
        shape : const CircleBorder(), 
        onPressed: _folderContentAddEnvelope,
        child : Icon(
          FeatherIcons.plus, 
          color : ColorPalette.white,
        ),
      ),

      body : GridView.builder(
        itemCount : envelopeItemLength,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1.6/2,
          crossAxisCount: 2,
        ),
        itemBuilder : (context, index){
          return Padding(
            padding: EdgeInsets.only(
              top : 4.h, 
              bottom : 16.h,
              left : (index%2==0) ? 
                16.w : 8.w,
              right : (index%2==0) ? 
                8.w : 16.w,
            ),
            child: MyEnvelopeWidget(
              envelope: envelopeItem[index],
              envelopeOpenContents: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder : (context) => EnvelopeContentPage(
                      folder: widget.folder,
                      envelope: envelopeItem[index] , 
                    )
                  )
                );
              },
            ),
          );
        }
      )
    );
  }

  void _folderContentAddEnvelope(){
    showDialog(
      context: context,
      builder: (context) {
        return MyEnvelopeDialogBoxWidget(
          controllerName: _enevelopeNameController,
          envelopeAmountcontrollerName: _enevelopeAmountController,
          dialogBoxHintText: "Untitled Envelope",
          dialogBoxTitle: "Add Envelope",
          dialogBoxErrorMessage: "Please enter a name for your Envelope",
          envelopeAmountHintText: "Starting Amount",
          dialogBoxOnTap: (){
            if (_enevelopeNameController.text.isNotEmpty){
              Envelope envelope = Envelope(
                envelopeName: _enevelopeNameController.text.trim(),
                envelopeStartingAmount: double.parse(_enevelopeAmountController.text.trim())
              );

              Provider.of<EnvelopeProvider>(
                context,
                listen : false
              ).addEnvelope(
                envelope.toMap(), 
                widget.folder.folderId
              );

              _enevelopeNameController.clear();
              _enevelopeAmountController.clear();
              Navigator.of(context).pop();
            }
          },
        );
      }
    );
    return;
  }
}