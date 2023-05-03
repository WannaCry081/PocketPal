import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


class MyTitleOptionWidget extends StatelessWidget {
  final String folderTitleText;
  final void Function() ? folderTitleOnTap;

  const MyTitleOptionWidget({ 
    super.key, 
    required this.folderTitleText,
    this.folderTitleOnTap,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 18.w,
        vertical: 10.h
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          titleText(
            "My Wall",
            titleWeight: FontWeight.w600,
            titleSize : 16.sp
          ),

          GestureDetector(
            onTap : folderTitleOnTap,
            child: bodyText(
              "View all",
              bodyWeight: FontWeight.w600,
              bodySize : 14.sp,
              bodyColor : ColorPalette.crimsonRed
            ),
          )
        ]
      ),
    );
  }
}