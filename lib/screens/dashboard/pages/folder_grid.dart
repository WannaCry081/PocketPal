import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import 'package:pocket_pal/screens/dashboard/pages/folder_content.dart';
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class FolderGridPage extends StatefulWidget {

  final bool isShared;

  const FolderGridPage({ 
    super.key,
    required this.isShared,
  });

  @override
  State<FolderGridPage> createState() => _FolderGridPageState();
}

class _FolderGridPageState extends State<FolderGridPage> {

  final TextEditingController _folderName = TextEditingController(text : "");
  @override
  void dispose(){
    super.dispose();
    _folderName.dispose();
    return;
  }

  @override
  Widget build(BuildContext context){

    final db = PocketPalDatabase();

    return Scaffold(
      appBar : AppBar(
        title : Text(
          (widget.isShared) ?
            "Group Folder" :
            "Personal Folder",
          style : GoogleFonts.poppins(
            fontSize : 16.sp
          )
        ),
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.rustic,
        onPressed: _dashboardAddFolder,
        child : Icon(
          Icons.add_rounded, 
          color: ColorPalette.white,
        ),
      ),

      body : Padding(
        padding : EdgeInsets.symmetric(
          horizontal: 7.w
        ),
        child : _dashboardFolderView(
          db
        )
      )
    );
  }


  Widget _dashboardFolderView(PocketPalDatabase db){
    return StreamBuilder(
      stream: db.getFolder(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Center(
            child : CircularProgressIndicator()
          );
        } else if (snapshot.hasData){
          
          final data = snapshot.data!;
          final itemList = data.where(
            (e) => e.folderIsShared == widget.isShared
          ).map(
            (e) => MyFolderWidget(
              folder: e,
              folderPositionBottom: 18.h + 20.w,
              folderPositionLeft: 18.w + 16.h,
              folderSize: 74,
              folderTitleSize: 14,
              folderDescriptionSize: 12,
              folderOnLongPress: (){},
              folderOnTap : () =>   
                _dashboardNavigateToFolder(e)
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
              "No Available Folder",
              style : GoogleFonts.poppins(
                fontSize : 14.sp
              )
            ),
          );
        }
      }
    );
  }

  void _dashboardAddFolder(){
    showDialog(
      context: context,
      builder: (context) {
        return MyDialogBoxWidget(
          controllerName: _folderName,
          dialogBoxHintText: "Untitled Wall",
          dialogBoxTitle: "Add Folder",
          dialogBoxErrorMessage: "Please enter a name for your Wall",
          dialogBoxOnTap: (){

            if (_folderName.text.isNotEmpty){
              Folder folder = Folder(
                folderName: _folderName.text.trim(),
                folderIsShared: widget.isShared
              );

              PocketPalDatabase().addFolder(
                folder.toMap()
              );

              _folderName.clear();
              Navigator.of(context).pop();
            }
          },
        );
      }
    );
    return;
  }

  void _dashboardNavigateToFolder(Folder folder){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => FolderContentPage(
          folder : folder
        )
      )
    );
    return;
  }
}