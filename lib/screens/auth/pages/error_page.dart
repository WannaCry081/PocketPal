import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";

class ErrorPage extends StatelessWidget {

  const ErrorPage({ Key ? key }) : super(key : key);
  
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: ColorPalette.midnightBlue.shade800,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/svg/Error.svg",
                  height: 400.h,
                  width : 400.w
                ),

                SizedBox( height : 100.h ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                    ),
                  child: PocketPalButton(
                    buttonOnTap: () {
                      Navigator.of(context).pop();
                    },
                    buttonHeight: 50.h,
                    buttonWidth: double.infinity,
                    buttonColor: ColorPalette.crimsonRed,
                    buttonChild: bodyText(
                        "Go back",
                        bodySize : 16.sp,
                        bodyWeight : FontWeight.w600,
                        bodyColor : ColorPalette.white, 
                      ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
