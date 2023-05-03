import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/providers/folder_provider.dart";
import "package:pocket_pal/screens/dashboard/pages/folder_content.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";
import "package:provider/provider.dart";

class FolderGridPage extends StatefulWidget {

  final TextEditingController folderNameController;
  final void Function() folderAddOnTap;

  const FolderGridPage({ 
    Key ? key,
    required this.folderNameController,
    required this.folderAddOnTap,
  }) : super(key : key);

  @override
  State<FolderGridPage> createState() => _FolderGridPageState();
}

class _FolderGridPageState extends State<FolderGridPage> {

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<FolderProvider>(
      context, 
      listen : true
    ).fetchFolder();
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
          "My Wall",
        )
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: widget.folderAddOnTap,
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
            child: MyFolderWidget(
              folder: folderItem[index],
              folderOpenContents: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder : (context) => FolderContentPage(
                      folder: folderItem[index]
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
}