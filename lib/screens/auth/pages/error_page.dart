import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";

class ErrorPage extends StatelessWidget {

  const ErrorPage({super.key});
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorPalette.navy,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical : 20.h
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/svg/Error.svg",
                    height: 400.h,
                    width : 400.w
                  ),

                  SizedBox( height : 80.h ),
                  PocketPalButton(
                    buttonOnTap: () {
                      Navigator.of(context).pop();
                    },
                    buttonHeight: 55.h,
                    buttonWidth: double.infinity,
                    buttonColor: ColorPalette.rustic,
                    buttonChild: Text("Go back",
                        style: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: ColorPalette.white,
                        )),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
