import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


class NoWifiPage extends StatelessWidget {
  const NoWifiPage({ Key? key }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body : Stack(
        alignment : Alignment.center,
        children : [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFFFFC8C2),
                  const Color.fromARGB(255, 255, 249, 249),
                  ColorPalette.white!
                ]
              ),
            ),
            child : SafeArea(
              child : Center(
                child: SingleChildScrollView(
                  child : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children : [
                      SvgPicture.asset(
                        "assets/svg/NoWifi.svg",
                        width : 60.w + 20.h
                      ),
              
                      SizedBox( height : 14.h),
                      titleText(
                        "Whoops!!",
                        titleSize : 28.sp,
                        titleColor : ColorPalette.crimsonRed,
                        titleWeight : FontWeight.w700
                      ),
              
                      SizedBox( height : 6.h),
                      bodyText(
                        "No internet connection found. Check your\nconnection or try again.",
                        bodyAlignment: TextAlign.center,
                        bodySize : 16.sp,
                        bodyColor : ColorPalette.grey
              
                      )
                    ]
                  )
                ),
              )
            )
          ),
        ]
      )
    );
  }
}