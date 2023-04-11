import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/screens/dashboard/pages/show_folder.dart";
import "package:pocket_pal/screens/dashboard/widgets/folder_widget.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class ShowMorePage extends StatefulWidget {

  final bool isShared;

  const ShowMorePage({ 
    super.key,
    required this.isShared,
  });

  @override
  State<ShowMorePage> createState() => _ShowMorePageState();
}

class _ShowMorePageState extends State<ShowMorePage> {

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
              folderSize: 200,
              folderTitleSize: 16,
              folderDescriptionSize: 14,
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
          dialogBoxHintText: "Folder Name",
          dialogBoxTitle: "Add Folder",
          dialogBoxOnTap: (){
            Folder folder = Folder(
              folderName: _folderName.text.trim(),
              folderIsShared: widget.isShared
            );

            PocketPalDatabase().addFolder(
              folder.toMap()
            );

            _folderName.clear();
            Navigator.of(context).pop();
          },
        );
      }
    );
    return;
  }

  void _dashboardNavigateToFolder(Folder folder){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => ShowFolderPage(
          folder : folder
        )
      )
    );
    return;
  }
}