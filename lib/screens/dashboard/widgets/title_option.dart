import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";


class MyTitleOptionWidget extends StatelessWidget {
  final String folderTitleText;
  final void Function() ? folderTitleOnTap;
  final double folderTitleTopSize;

  const MyTitleOptionWidget({ 
    super.key, 
    required this.folderTitleText,
    this.folderTitleOnTap,
    required this.folderTitleTopSize,
  });

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.only(
        right: 14.w,
        left: 14.w,
        top: folderTitleTopSize,
        bottom : 8.w
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children : [
          Text(
            folderTitleText, 
            style : GoogleFonts.poppins(
              fontSize : 14.sp
            )
          ),

          GestureDetector(
            onTap : folderTitleOnTap,
            child: Text(
              "show more", 
              style : GoogleFonts.poppins(
                fontSize : 14.sp,
                fontWeight : FontWeight.w500,
                color : ColorPalette.rustic
              )
            ),
          )
        ]
      ),
    );
  }
}