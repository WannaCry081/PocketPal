import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


class MyCardWidget extends StatelessWidget {
  const MyCardWidget({ Key ? key }) : super(key : key);

  @override
  Widget build(BuildContext context){
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;


    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 10.h,
        horizontal: 16.0),
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
                  color: ColorPalette.crimsonRed[300 - (i*100)],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          Container(
            height: 160.h,
            decoration: BoxDecoration(
              color: Color(0xffFFFBFF),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: ColorPalette.crimsonRed.shade300,
                width: 2
              ),
            ),
          ),
          Positioned(
            right: -50,
            bottom: -5,
            child: SvgPicture.asset(
              "assets/svg/dashboard_card.svg",
              height: 160.h,
            ),
          ),
          Positioned(
            left: 10,
            top: 70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                titleText(
                  "Bugdeting is\n    easy as",
                  titleColor: ColorPalette.grey,
                  titleSize: 14.sp,
                  titleWeight: FontWeight.w400,
                  titleHeight: 1.2
                ),
                titleText(
                  "1, 2, 3!",
                  titleColor: ColorPalette.crimsonRed,
                  titleSize: 26.sp,
                  titleWeight: FontWeight.w700,
                ),
              ],
            )
          )
      ],
      ),
    );
  }
}