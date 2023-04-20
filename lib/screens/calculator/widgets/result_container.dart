import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class MyResultWidget extends StatelessWidget {
  final String userInput;
  final String result;
  final double screenHeight;
  final double screenWidth;

  const MyResultWidget({
    required this.userInput,
    required this.result,
    required this.screenHeight,
    required this.screenWidth,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xFFFEFEFE),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            height: (screenHeight / 3.5) * 0.5,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.bottomRight,
            child: Text(
              userInput,
              style: GoogleFonts.poppins(
                fontSize: 32.sp
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5),
              child: SizedBox(
                width: screenWidth,
                child: Text(
                  result,
                  softWrap: true,
                  textAlign: TextAlign.right,
                  style: GoogleFonts.poppins(
                    fontSize: 48.sp,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ),
          )
        ],
      )
    );
  }
}