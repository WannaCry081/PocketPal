import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";

import "package:pocket_pal/screens/dashboard/widgets/dialog_box.dart";


class ShowFolderPage extends StatefulWidget {
  final Folder folder;

  const ShowFolderPage({ 
    super.key,
    required this.folder
  });

  @override
  State<ShowFolderPage> createState() => _ShowFolderPageState();
}

class _ShowFolderPageState extends State<ShowFolderPage> {

  final TextEditingController _envelopeName = TextEditingController(text : "");

  @override
  void dispose(){
    super.dispose();
    _envelopeName.dispose();
    return;
  }

  @override 
  Widget build(BuildContext context){
    return Scaffold(
      appBar : AppBar(
        title : Text(
          widget.folder.folderName!,
          style : GoogleFonts.poppins(
            fontSize : 16.sp
          )
        )
      ),

      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorPalette.rustic,
        onPressed: _dashboardAddFolder,
        child : Icon(
          Icons.add_rounded, 
          color: ColorPalette.white,
        ),
      ),

    );
  }

  void _dashboardAddFolder(){
    showDialog(
      context: context,
      builder: (context) {
        return MyDialogBoxWidget(
          controllerName: _envelopeName,
          dialogBoxHintText: "Envelope Name",
          dialogBoxTitle: "Add Envelope",
          dialogBoxOnTap: (){
            
          },
        );
      }
    );
    return;
  }
}