import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/services/authentication_service.dart';

class MyCardWidget extends StatelessWidget {
  const MyCardWidget({super.key});

  @override
  Widget build(BuildContext context) {

    final auth = PocketPalAuthentication();

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical : 10.h
      ),
      child: Stack(
        fit : StackFit.passthrough,
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          for (int i=2; i>=1; i--)
            Positioned(
              bottom : (-i * 10),
              child: Container(
                height : 90.h + 20.w,
                width : (screenWidth - ((screenWidth * 0.06)*2))- (30*i),
                decoration: BoxDecoration(
                  color: ColorPalette.rustic[300 - (i*100)],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          Container(
          height : 90.h + 20.w,
          decoration: BoxDecoration(
            color: Color(0xffFFFBFF),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: ColorPalette.rustic,
              width: 2
            ),
          ),
        ),
        Positioned(
          right: -20,
          bottom: -5,
          child: SvgPicture.asset(
            "assets/svg/dashboard_card.svg",
            height: 120.h,
          ),
        ),
        Positioned(
          left: 10,
          top: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome!",
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  color: ColorPalette.rustic,
                  fontWeight: FontWeight.w600
                )
              ),
              Text(
                "Let's get to the top of\nyour expenses today!",
                style: GoogleFonts.poppins(
                  fontSize: 12.sp,
                  color: ColorPalette.grey,
                  height: 1
                )
              ),
            ],
          ),
        )
        ],
      ),
    );
  }
}