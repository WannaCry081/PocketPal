import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
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
              size : 60.sp,
              color : Colors.redAccent[400]
            ),

            SizedBox( height : 20.h ),
            Text(
              dialogBoxTitle,
              style : GoogleFonts.openSans(
                fontSize : 20.sp,
                fontWeight : FontWeight.w500
              )
            ),

            SizedBox( height : 6.h ),
            SizedBox(
              width : 180.w,
              child: Text(
                dialogBoxDescription,
                textAlign: TextAlign.center,
                style : GoogleFonts.montserrat(
                  fontSize : 12.sp
                )
              ),
            ),

            SizedBox( height : 16.h ),
            PocketPalButton(
              buttonOnTap: () => Navigator.of(context).pop(), 
              buttonWidth: 100.w, 
              buttonHeight: 36.h, 
              buttonBorderRadius: 100,
              buttonColor: ColorPalette.rustic, 
              buttonChild: Text(
                "Okay",
                style : GoogleFonts.poppins(
                  color : ColorPalette.white,
                  fontSize : 14.sp
                )
              )
            )
          ]
        ),
      )
    );
  }
}