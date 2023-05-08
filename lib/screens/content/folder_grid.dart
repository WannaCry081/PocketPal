import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";

import "package:pocket_pal/providers/folder_provider.dart";
import 'package:pocket_pal/utils/folder_util.dart';
import "package:pocket_pal/widgets/pocket_pal_folder.dart";

import 'package:pocket_pal/screens/dashboard/widgets/folder_bottom_edit_sheet.dart';
import 'package:pocket_pal/screens/content/folder_content.dart';
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";


class FolderGridPage extends StatefulWidget {

  final String ? code;
  final String wallName;

  const FolderGridPage({ 
    Key ? key,
    this.code,
    this.wallName = ""
  }) : super(key : key);

  @override
  State<FolderGridPage> createState() => _FolderGridPageState();
}

class _FolderGridPageState extends State<FolderGridPage> {

  final TextEditingController _folderNameController = TextEditingController(text : "");
  
  @override
  void initState(){
    super.initState();
    Provider.of<FolderProvider>(
      context, 
      listen : false
    ).fetchFolder(code : widget.code);
    return;
  } 

  @override
  void dispose(){
    super.dispose();
    _folderNameController.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){
    return Consumer<FolderProvider>(
      builder: (context, folderProvider, child) {
        return Scaffold(
          appBar : AppBar(
            title : titleText(
              (widget.wallName.isEmpty) ? "Personal Folder" : "${widget.wallName} Folder" , 
              titleWeight : FontWeight.w600
            )
          ),
    
          floatingActionButton: FloatingActionButton(
            onPressed: () => _dashboardAddFolder(folderProvider),
            backgroundColor: ColorPalette.crimsonRed,
            shape: const CircleBorder(),
            child : Icon(
              FeatherIcons.plus, 
              color : ColorPalette.white
            ),
          ),
          
          body : GridView.builder(
            itemCount : folderProvider.getFolderList.length,
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
                child: PocketPalFolder(
                  folder: folderProvider.getFolderList[index],
                  folderEditContents: () => _dashboardFolderEdit(
                    folderProvider, 
                    folderProvider.getFolderList[index]
                  ),
                  folderOpenContents: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder : (context) => FolderContentPage(
                          folder: folderProvider.getFolderList[index],
                          code: widget.code,
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
    );
  }

  void _dashboardAddFolder(FolderProvider folderProvider){
    showDialog(
      context: context,
      builder: (context) {

        return MyDialogBoxWidget(
          controllerName: _folderNameController,
          dialogBoxConfirmMessage : "Create",
          dialogBoxHintText: "Untitled Folder",
          dialogBoxTitle: "Add Folder",
          dialogBoxErrorMessage: "Please enter a name for your Folder",
          dialogBoxOnCancel: (){
            _folderNameController.clear();
            Navigator.of(context).pop();
          },
          dialogBoxOnCreate: (){
            folderProvider.addFolder(
              Folder(
                folderName: _folderNameController.text.trim(),
              ).toMap(),
              code : widget.code,
            );
            _folderNameController.clear();
            Navigator.of(context).pop();
          },
        );
      }
    );
    return;
  }

  void _dashboardFolderEdit(FolderProvider folderProvider, Folder folder){
    showModalBottomSheet(
      isDismissible: false,
      context: context, 
      builder: (context){
        return MyFolderBottomEditSheetWidget(
          folder : folder,
          bottomSheetOnDelete: (){
            folderProvider.deleteFolder(folder.folderId);
            Navigator.of(context).pop();
          },
          bottomSheetOnEdit: (){
            Navigator.of(context).pop();
            showDialog(
              context : context,
              builder : (context) {
                return MyDialogBoxWidget(
                  controllerName: _folderNameController,
                  dialogBoxHintText: folder.folderName,
                  dialogBoxConfirmMessage : "Rename",
                  dialogBoxTitle: "Rename Folder",
                  dialogBoxErrorMessage: "Please enter a name for your Folder",
                  dialogBoxOnCancel: (){
                    _folderNameController.clear();
                    Navigator.of(context).pop();
                  },
                  dialogBoxOnCreate: (){
                    folderProvider.updateFolder(
                      folder.folderId,
                      { "folderName" : _folderNameController.text.trim() }
                    );
                    _folderNameController.clear();
                    Navigator.of(context).pop();
                  },
                );
              }
            );
          },
        );
      }
    );
  }
}