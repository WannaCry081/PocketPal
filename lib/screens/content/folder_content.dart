import "package:flutter/material.dart";
import "package:flutter_staggered_animations/flutter_staggered_animations.dart";
import "package:pocket_pal/providers/chatbox_provider.dart";
import "package:pocket_pal/providers/user_provider.dart";
import "package:pocket_pal/utils/recent_tab_util.dart";
import "package:provider/provider.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import 'package:pocket_pal/screens/content/folder_chat_box.dart';

import "package:pocket_pal/widgets/pocket_pal_envelope.dart";
import "package:pocket_pal/screens/envelope/envelope.dart";
import "package:pocket_pal/screens/envelope/widgets/envelope_dialog_box.dart";

import "package:pocket_pal/utils/folder_util.dart";
import "package:pocket_pal/utils/envelope_util.dart";

import "package:pocket_pal/providers/envelope_provider.dart";
import "package:pocket_pal/screens/dashboard/widgets/envelope_bottom_edit_sheet.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";



class FolderContentPage extends StatefulWidget {
  
  final Folder folder;
  final String ? code;

  const FolderContentPage({
    Key ? key,
    required this.folder,
    this.code
  }) : super( key : key );

  @override
  State<FolderContentPage> createState() => _FolderContentPageState();
}


class _FolderContentPageState extends State<FolderContentPage>{

  final TextEditingController _enevelopeAmountController = TextEditingController(text : "");
  final TextEditingController _enevelopeNameController = TextEditingController(text : "");
  
  @override 
  void initState(){
    super.initState();
    Provider.of<EnvelopeProvider>(
      context,
      listen : false
    ).fetchEnvelope(
      widget.folder.folderId,
      code : widget.code,
    );
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
    return Consumer<EnvelopeProvider>(
      builder: (context,envelopeProvider, child) {

        final List<Envelope> envelopeList = envelopeProvider.getEnvelopeList;
        final int envelopeListLength = envelopeList.length;

        return Consumer<ChatBoxProvider>(
          builder: (context, chatBoxProvider, child) {
            
            return Consumer<UserProvider>(
              builder: (context, userProvider, child) {

                return Scaffold(
                  appBar : AppBar(
                    title : titleText(
                      "${widget.folder.folderName} Folder",
                      titleWeight : FontWeight.w600
                    ),
                    actions: [
                      if (widget.code != null) ... [
                        IconButton(
                          icon : const Icon(
                            FeatherIcons.messageCircle,
                            color : Colors.black
                          ),
                          onPressed: (){
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder : (context) => FolderChatBox(
                                  folder : widget.folder,
                                  code : widget.code
                                )
                              )
                            ).then((value){
                              chatBoxProvider.clearChatConversation();
                            });
                          },
                        )
                      ] 
                    ],
                  ),
                
                  floatingActionButton: FloatingActionButton(
                    backgroundColor: ColorPalette.crimsonRed,
                    onPressed: () => _folderContentAddEnvelope(envelopeProvider),
                    child : Icon(
                      FeatherIcons.plus, 
                      color : ColorPalette.white,
                    ),
                  ),
                
                  body : AnimationLimiter(
                    child: GridView.builder(
                      itemCount : envelopeListLength,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        childAspectRatio: 1.6/2,
                        crossAxisCount: 2,
                      ),
                      itemBuilder : (context, index){
                        return AnimationConfiguration.staggeredGrid(
                          position : index,
                          duration : const Duration(milliseconds: 400),
                          columnCount : envelopeListLength, 
                          child: ScaleAnimation(
                            child: FadeInAnimation(
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top : 4.h, 
                                  bottom : 16.h,
                                  left : (index%2==0) ? 
                                    16.w : 8.w,
                                  right : (index%2==0) ? 
                                    8.w : 16.w,
                                ),
                                child: PocketPalEnvelope(
                                  envelope: envelopeList[index],
                                  envelopeEditContents: () => 
                                    _folderContentEditEnvelope(
                                      envelopeProvider,
                                      envelopeList[index]
                                    ),
                                  envelopeOpenContents: (){
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder : (context) => EnvelopeContentPage(
                                          folder: widget.folder,
                                          envelope: envelopeList[index], 
                                          code : widget.code
                                        )
                                      )
                                    ).then((value){
                                      userProvider.addTabItem(
                                        RecentTabItem(
                                          itemCategory: "Envelope",
                                          itemName: envelopeList[index].envelopeName,
                                          itemDocId: envelopeList[index].envelopeId,
                                          itemDocName: widget.folder.folderId,
                                        ).toMap()
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      }
                    ),
                  )
                );
              }
            );
          }
        );
      }
    );
  }

  void _folderContentAddEnvelope(EnvelopeProvider envelopeProvider){
    showDialog(
      context: context,
      builder: (context) {
        return MyEnvelopeDialogBoxWidget(
          controllerName: _enevelopeNameController,
          controllerAmount: _enevelopeAmountController,
          dialogBoxHintText: "Untitled Envelope",
          dialogBoxTitle: "Add Envelope",
          dialogBoxErrorMessage: "Please enter a name for your Envelope",
          envelopeAmountHintText: "Starting Amount",
          dialogBoxOnTap: (){
            Envelope envelope = Envelope(
              envelopeName: _enevelopeNameController.text.trim(),
              envelopeStartingAmount: double.parse(_enevelopeAmountController.text.trim())
            );

            envelopeProvider.createEnvelope(
              envelope.toMap(), 
              widget.folder.folderId,
              code : widget.code,
            );

            _enevelopeNameController.clear();
            _enevelopeAmountController.clear();
            Navigator.of(context).pop();
          }
        );
      }
    );
    return;
  }

  void _folderContentEditEnvelope(EnvelopeProvider envelopeProvider, Envelope envelope){
    showModalBottomSheet(
      context: context, 
      isDismissible: false,
      builder: (context){
        return MyEnvelopeBottomEditSheetWidget(
          envelope: envelope,
          bottomSheetOnDelete: (){
            envelopeProvider.deleteEnvelope(
              widget.folder.folderId,
              envelope.envelopeId,
              code : widget.code
            );
            Navigator.of(context).pop();
          },
          bottomSheetOnEdit: (){
            Navigator.of(context).pop();

             showDialog(
              context : context,
              builder : (context) {
                return MyDialogBoxWidget(
                  controllerName: _enevelopeNameController,
                  dialogBoxHintText: envelope.envelopeName,
                  dialogBoxConfirmMessage : "Rename",
                  dialogBoxTitle: "Rename Envelope",
                  dialogBoxErrorMessage: "Please enter a name for your Envelope",
                  dialogBoxOnCancel: (){
                    _enevelopeNameController.clear();
                    Navigator.of(context).pop();
                  },
                  dialogBoxOnCreate: (){
                    envelopeProvider.updateEnvelope(
                      { "envelopeName" : _enevelopeNameController.text.trim() },
                      widget.folder.folderId, 
                      envelope.envelopeId,
                      code : widget.code
                    );
                    _enevelopeNameController.clear();
                    Navigator.of(context).pop();
                  },
                );
              }
            );
          },
        );
      }
    );
    return;
  }
}