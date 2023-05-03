import "package:flutter/material.dart"; 
import "package:google_fonts/google_fonts.dart"; 
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


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
        bodyText(
          hyperlinkText,
          bodySize : 14.sp
        ),

        GestureDetector(
          onTap : hyperlinkOnTap,
          child : bodyText(
            hyperlinkLink,
            bodySize : 14.sp,
            bodyColor : ColorPalette.crimsonRed
          )
        )
      ]
    );
  }
}