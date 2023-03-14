import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorPalette.navy,
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: screenHeight * 0.02),
                SvgPicture.asset(
                  "assets/errorpage.svg",
                  height: 400,
                ),
                const Spacer(),
                PocketPalButton(
                  buttonOnTap: () {},
                  buttonHeight: 60,
                  buttonWidth: screenWidth - (screenWidth * 0.16),
                  buttonColor: ColorPalette.rustic,
                  buttonBorderRadius: 10,
                  buttonChild: Text("Go back",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: ColorPalette.white,
                      )),
                ),
                SizedBox(height: screenHeight * 0.04),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
