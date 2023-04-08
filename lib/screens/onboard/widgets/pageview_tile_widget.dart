import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";


class MyPageViewTileWidget extends StatelessWidget {

  final String pageViewTileImage;
  final String pageViewTileTitle;
  final String pageViewTileDescription;

  const MyPageViewTileWidget({
    super.key,
    required this.pageViewTileImage,
    required this.pageViewTileTitle,
    required this.pageViewTileDescription,
  });

  @override
  Widget build(BuildContext context){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        SvgPicture.asset(
          pageViewTileImage,
          width : 300.w,
          height : 300.h
        ),
    
        SizedBox( height : 30.h),
        Text(
          pageViewTileTitle,
          textAlign: TextAlign.center,
          style : GoogleFonts.poppins(
            fontSize : 22.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
    
        SizedBox( height : 12.h),
        Text(
          pageViewTileDescription,
          textAlign: TextAlign.center,
          style : GoogleFonts.poppins(
            fontSize : 14.sp,
            color : ColorPalette.grey
          ),
        )
      ]
    );
  }
}