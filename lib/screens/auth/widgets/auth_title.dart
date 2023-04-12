import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";


class MyAuthTitleWidget extends StatelessWidget {

  final String authTitleTitle;
  final String authTitleMessage;
  final double authTitleTitleSize;
  final double authTitleTitleMessageSize;

  const MyAuthTitleWidget({ 
    super.key,
    required this.authTitleMessage,
    required this.authTitleTitle,

    this.authTitleTitleSize = 0,
    this.authTitleTitleMessageSize = 0
  });

  @override
  Widget build(BuildContext context){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children : [
        Text(
          authTitleTitle,
          style : GoogleFonts.poppins(
            fontSize : authTitleTitleSize,
            fontWeight : FontWeight.w600
          )
        ),

        SizedBox( height : 4.h),
        Text(
          authTitleMessage,
          style : GoogleFonts.montserrat(
            color : ColorPalette.grey,
            fontWeight: FontWeight.w500,
            fontSize : authTitleTitleMessageSize,
          )
        ),
      ]
    );
  }
} 