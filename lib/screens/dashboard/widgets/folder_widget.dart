import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";

import "package:pocket_pal/utils/folder_structure_util.dart";


class MyFolderWidget extends StatelessWidget {
  
  final Folder folder;
  final void Function() ? folderOpenContents;
  final void Function() ? folderEditContents;

  const MyFolderWidget({ 
    Key ? key,
    required this.folder,
    this.folderOpenContents,
    this.folderEditContents
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap : folderOpenContents,
      onLongPress : folderEditContents,
      child: Container(
        width : 140.w,
        height : 160.h + 20.w,
        decoration : BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color : ColorPalette.rustic[50]
        ),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
    
            SvgPicture.asset(
              "assets/icon/Folder.svg",
              width : 90.h,
              height : 90.h
            ),
    
            SizedBox( height : 8.h ), 
    
            titleText(
              folder.folderName,
              titleWeight: FontWeight.w600,
              titleSize : 14.sp
            ),
    
            SizedBox( height : 2.h ), 
            bodyText( 
              "${folder.folderNumberOfEnvelopes} Envelopes",
              bodySize : 12.sp,
              bodyColor: ColorPalette.grey
            )
          ]
        )
      ),
    );
  }
}