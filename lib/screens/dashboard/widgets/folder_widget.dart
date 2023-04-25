import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";


class MyFolderWidget extends StatelessWidget {
  final Folder folder;
  final double folderSize;
  final double folderTitleSize;
  final double folderPositionBottom;
  final double folderPositionLeft;
  final double folderDescriptionSize;
  final void Function() ? folderOnTap;
  final void Function() ? folderOnLongPress;

  const MyFolderWidget({ 
    super.key, 
    required this.folder,
    this.folderSize = 70, 
    this.folderTitleSize = 14,
    this.folderDescriptionSize = 12,
    this.folderPositionBottom = 30,
    this.folderPositionLeft = 25,
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
            width : folderSize.w + folderSize.h, 
            height : folderSize.h + folderSize.w
          ),
          
          Positioned(
            bottom : folderPositionBottom,
            left : folderPositionLeft,
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children : [
                Text(
                  (folder.folderName.length > 10) ? 
                    "${folder.folderName.substring(0, 10)}..." : 
                    folder.folderName, 
                  style : GoogleFonts.montserrat(
                    fontSize : folderTitleSize.sp,
                    fontWeight: FontWeight.w600
                  )
                ),
                Text(
                  "${folder.folderDate.day}/${folder.folderDate.month}/${folder.folderDate.year} ", 
                  style : GoogleFonts.montserrat(
                    fontSize : folderDescriptionSize.sp,
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