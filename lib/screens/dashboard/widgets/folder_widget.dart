import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class MyFolderWidget extends StatelessWidget {
  final Folder folder;
  final void Function() ? folderOnTap;
  final void Function() ? folderOnLongPress;

  const MyFolderWidget({ 
    super.key, 
    required this.folder,
    this.folderOnLongPress,
    this.folderOnTap,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: folderOnTap,
      onLongPress: folderOnLongPress,
      child: Stack(
        alignment : Alignment.center,
        children : [  
          SvgPicture.asset(
            "assets/icon/Folder.svg",
            width : 160.w,
            height : 160.h
          ),
          
          Positioned(
            bottom : 30,
            left : 25,
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Text(
                  folder.folderName!, 
                  style : GoogleFonts.montserrat(
                    fontSize : 14.sp,
                    fontWeight: FontWeight.w600
                  )
                ),
                Text(
                  "${folder.folderIsShared}", 
                  style : GoogleFonts.montserrat(
                    fontSize : 12.sp,
                    fontWeight: FontWeight.w600,
                    color : ColorPalette.grey
                  )
                ),
              ]
            )
          )
        ]
      ),  
    );
  }
}