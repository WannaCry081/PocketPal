import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';

class MyBudgetValues extends StatelessWidget {
  final String name;
  final String value;
  final double fontSize;

  const MyBudgetValues({
    required this.name,
    required this.value,
    required this.fontSize,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            bodyText(
              name,
              bodySize: 16.sp,
              bodyWeight: FontWeight.w600,
              bodyColor: ColorPalette.white,
            ),
            Row(
               children: [
                 SvgPicture.asset(
                    "assets/icon/peso_sign.svg",
                    height: 14.h,
                    color: ColorPalette.white,
                ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: titleText(
                  value,
                  titleColor: ColorPalette.white,
                  titleWeight: FontWeight.bold,
                  titleSize: fontSize,
                ),
            )
            ],
          ),
          ],
        )
      ],
    );
  }
}