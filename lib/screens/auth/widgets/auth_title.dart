import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


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
        titleText(
          authTitleTitle,
          titleSize : authTitleTitleSize,
          titleWeight : FontWeight.w600
        ),

        SizedBox( height : 8.h),
        bodyText(
          authTitleMessage,
          bodyColor : ColorPalette.grey,
          bodyWeight: FontWeight.w500,
          bodySize : authTitleTitleMessageSize,
        ),
      ]
    );
  }
} 