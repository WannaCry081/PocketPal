import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";


class MyCardWidget extends StatelessWidget {

  const MyCardWidget({ super.key });

  @override 
  Widget build(BuildContext context){

    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical : 10.h
      ),
      child: Stack(
        alignment : Alignment.center,
        fit : StackFit.passthrough,
        clipBehavior: Clip.none,
        children : [

          for (int i=2; i>=1; i--)
            Positioned(
              bottom : (-i * 10),
              child: Container(
                height : 180.h,
                width : (screenWidth - ((screenWidth * 0.06)*2))- (30*i),
                decoration: BoxDecoration(
                  color: ColorPalette.rustic[300 - (i*100)],
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          
          Container(
            height : 180.h,
            decoration: BoxDecoration(
              color: ColorPalette.rustic,
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ]
      ),
    );

  }
}

