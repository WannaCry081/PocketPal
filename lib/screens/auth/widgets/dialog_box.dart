import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";


class MyDialogBoxWidget extends StatelessWidget {

  final String dialogBoxTitle;
  final String dialogBoxDescription;

  const MyDialogBoxWidget({ 
    super.key,
    required this.dialogBoxTitle,
    required this.dialogBoxDescription,
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      content : SizedBox(
        height : 240.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            Icon(
              FeatherIcons.xCircle,
              size : 70.sp,
              color : ColorPalette.crimsonRed
            ),

            SizedBox( height : 20.h ),
            titleText(
              dialogBoxTitle,
              titleSize : 20.sp,
              titleWeight : FontWeight.w600
            ),

            SizedBox( height : 6.h ),
            SizedBox(
              width : 180.w,
              child: bodyText(
                dialogBoxDescription,
                bodyAlignment: TextAlign.center,
                bodySize : 12.sp
              ),
            ),

            SizedBox( height : 16.h ),
            PocketPalButton(
              buttonOnTap: () => Navigator.of(context).pop(), 
              buttonWidth: 100.w, 
              buttonHeight: 36.h, 
              buttonBorderRadius: 100,
              buttonColor: ColorPalette.crimsonRed, 
              buttonChild: bodyText(
                "Okay",
                bodyColor : ColorPalette.white,
                bodySize : 14.sp,
                bodyWeight: FontWeight.w600
              )
            )
          ]
        ),
      )
    );
  }
}