import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';

class TotalBalanceCard extends StatelessWidget {

  final double width;
  final String balance;

   TotalBalanceCard({
    super.key,
    required this.width,
    required this.balance,
    });

  @override
  Widget build(BuildContext context) {
    return Glassbox(
      width: width ,
      height: 175,
      borderRadius: 20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Total Balance",
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                color: ColorPalette.white,
                fontWeight: FontWeight.w600,
              )
            ),
            Text(
              "Php $balance",
              style: GoogleFonts.poppins(
                fontSize: 45.sp,
                color: ColorPalette.white,
                fontWeight: FontWeight.bold,
                height: 1.3
              )
            ),
          ],
        ),
      )
    );
  }
}