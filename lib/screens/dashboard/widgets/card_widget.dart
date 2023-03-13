import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";


class MyCardWidget extends StatelessWidget {
  final double screenHeight;
  final double screenWidth;

  const MyCardWidget({ 
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override 
  Widget build(BuildContext context){
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.passthrough,
      clipBehavior: Clip.none,
      children: [

        Positioned(
          bottom : -20,
          child: Container(
            height : 180,
            width : (screenWidth - ((screenWidth * 0.06)*2))- 60,
            decoration: BoxDecoration(
              color: ColorPalette.rustic[100],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        
        Positioned(
          bottom : -10,
          child: Container(
            height : 180,
            width : (screenWidth - ((screenWidth * 0.06)*2))- 30,
            decoration: BoxDecoration(
              color: ColorPalette.rustic[200],
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        
        Container(
          height : 180,
          decoration: BoxDecoration(
            color: ColorPalette.rustic,
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        
      ],
    );
  }
}