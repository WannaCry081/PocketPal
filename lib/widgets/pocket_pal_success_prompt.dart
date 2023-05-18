import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/screens/auth/auth_builder.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";


class PocketPalSuccessPrompt extends StatelessWidget {
  final String pocketPalSuccessTitle;
  final String pocketPalSuccessMessage;

  const PocketPalSuccessPrompt({
    Key ? key,
    required this.pocketPalSuccessTitle,
    required this.pocketPalSuccessMessage,
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      content : SizedBox(
        height : 160.h,
        child: Stack(
          fit: StackFit.passthrough,
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top : -60.h,
              child :  Container(
                width : 80.h,
                height : 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color : Colors.green
                ),
                child: Icon(
                  FeatherIcons.checkCircle,
                  size : 60.sp,
                  color : Colors.white
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children : [
                SizedBox( height : 20.h ),
                bodyText(
                  pocketPalSuccessTitle,
                  bodySize: 18.sp,
                  bodyWeight: FontWeight.w800
                ),
            
                SizedBox( height : 10.h ),
                SizedBox(
                  width : 180.w,
                  child: bodyText(
                    pocketPalSuccessMessage,
                    bodyAlignment: TextAlign.center,
                    bodySize: 12.sp
                  ),
                ),
            
                SizedBox( height : 20.h ),
                PocketPalButton(
                  buttonOnTap: (){
                    Navigator.of(context).pop();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder : (context) => const AuthViewBuilder()
                      )
                    );
                  }, 
                  buttonWidth: 100.w, 
                  buttonHeight: 36.h, 
                  buttonBorderRadius: 100,
                  buttonColor: ColorPalette.crimsonRed, 
                  buttonChild: titleText(
                    "Close",
                    titleSize : 14.sp,
                    titleColor: ColorPalette.white
                  )
                )
              ]
            ),
          ],
        ),
      )
    );
  }
}

