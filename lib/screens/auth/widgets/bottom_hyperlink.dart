import "package:flutter/material.dart"; 
import "package:google_fonts/google_fonts.dart"; 
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";


class MyBottomHyperlinkWidget extends StatelessWidget {

  final void Function() ? hyperlinkOnTap;
  final String hyperlinkText;
  final String hyperlinkLink;

  const MyBottomHyperlinkWidget({ 
    super.key,
    required this.hyperlinkOnTap,
    required this.hyperlinkText,
    required this.hyperlinkLink,
  });

  @override 
  Widget build(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        Text(
          hyperlinkText,
          style : GoogleFonts.poppins(
            fontSize : 12.sp
          )
        ),

        GestureDetector(
          onTap : hyperlinkOnTap,
          child : Text(
            hyperlinkLink,
            style : GoogleFonts.poppins(
              fontSize : 12.sp,
              color : ColorPalette.crimsonRed
            )
          )
        )
      ]
    );
  }
}