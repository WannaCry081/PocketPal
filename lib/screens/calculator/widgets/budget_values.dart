import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

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
      children: [
        Column(
          children: [
            Text(
              name,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
               children: [
                 SvgPicture.asset(
                    "assets/icon/peso_sign.svg",
                    height: 14.h,
                    color: ColorPalette.rustic,
                ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                  value,
                  style: GoogleFonts.poppins(
                    color: ColorPalette.rustic,
                    fontSize: fontSize,
                    fontWeight: FontWeight.bold
                  )
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