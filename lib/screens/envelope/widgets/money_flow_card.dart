import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';

class MoneyFlowCard extends StatelessWidget {
  final double width;
  final String amount;
  final String name;
  final double fontSize;


  const MoneyFlowCard({
    super.key,
    required this.name,
    required this.width,
    required this.amount,
    required this.fontSize,
    
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFea5753),
              Color(0xFFfa9372),
            ]
          ),
         boxShadow: [
              BoxShadow(
                color: Colors.grey.shade400,
                offset: Offset(4,4),
                blurRadius: 10.0,
                spreadRadius: 0
              ),
            ]
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox ( width: 10),
            Text(
              "$name",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                color: ColorPalette.black,
                fontWeight: FontWeight.w600,
              )
            ),
            const SizedBox ( height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                    "assets/icon/peso_sign.svg",
                    height: 16.h,
                    color: ColorPalette.white,
                ),
                Text(
                  "$amount",
                  style: GoogleFonts.poppins(
                    fontSize: fontSize,
                    color: ColorPalette.white,
                    fontWeight: FontWeight.w600,
                    height: 1.3
                  )
                ),
              ],
            ),
          ],
        ),
      )
    );
  }
}