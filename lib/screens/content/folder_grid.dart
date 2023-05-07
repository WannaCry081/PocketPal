import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";

import "package:pocket_pal/providers/folder_provider.dart";
import 'package:pocket_pal/utils/folder_util.dart';
import "package:pocket_pal/widgets/pocket_pal_folder.dart";

import "package:pocket_pal/screens/dashboard/widgets/bottom_edit_sheet.dart";
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
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<FolderProvider>(
      context, 
      listen : true
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

    final FolderProvider folderProvider = Provider.of<FolderProvider>(context);
    final List<Folder> folderItem = folderProvider.getFolderList;
    final int folderItemLength = folderItem.length;

    return Scaffold(
      appBar : AppBar(
        title : titleText(
          (widget.code!.isEmpty) ? "Personal Wall" : "${widget.wallName} Wall" ,
          titleWeight : FontWeight.w600
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _dashboardAddFolder,
        backgroundColor: ColorPalette.crimsonRed,
        shape: const CircleBorder(),
        child : Icon(
          FeatherIcons.plus, 
          color : ColorPalette.white
        ),
      ),
      
      body : GridView.builder(
        itemCount : folderItemLength,
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
              folder: folderItem[index],
              folderEditContents: () => _dashboardFolderEdit(
                folderItem[index]
              ),
              folderOpenContents: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder : (context) => FolderContentPage(
                      folder: folderItem[index],
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

  void _dashboardAddFolder(){
    showDialog(
      context: context,
      builder: (context) {

        return MyDialogBoxWidget(
          controllerName: _folderNameController,
          dialogBoxHintText: "Untitled Wall",
          dialogBoxTitle: "Add Wall",
          dialogBoxErrorMessage: "Please enter a name for your Wall",
          dialogBoxOnCancel: (){
            _folderNameController.clear();
            Navigator.of(context).pop();
          },
          dialogBoxOnCreate: (){
            Provider.of<FolderProvider>(
              context, 
              listen: false
            ).addFolder(
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

   void _dashboardFolderEdit(Folder folder){
    showModalBottomSheet(
      context: context, 
      builder: (context){
        return MyBottomEditSheetWidget(
          folder : folder,
          bottomSheetOnDelete: (){
            Provider.of<FolderProvider>(
              context, 
              listen: false
            ).deleteFolder(
              folder.folderId,
              code : widget.code,
            );
            Navigator.of(context).pop();
          },
          bottomSheetOnEdit: (){},
        );
      }
    );
  }
}