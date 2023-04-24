import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
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
                Text(
                  pocketPalSuccessTitle,
                  style : GoogleFonts.openSans(
                    fontSize : 18.sp,
                    fontWeight : FontWeight.w800
                  )
                ),
            
                SizedBox( height : 10.h ),
                SizedBox(
                  width : 180.w,
                  child: Text(
                    pocketPalSuccessMessage,
                    textAlign: TextAlign.center,
                    style : GoogleFonts.montserrat(
                      fontSize : 12.sp
                    )
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
                  buttonColor: ColorPalette.rustic, 
                  buttonChild: Text(
                    "Close",
                    style : GoogleFonts.poppins(
                      color : ColorPalette.white,
                      fontSize : 14.sp
                    )
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

