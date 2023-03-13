import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";


class MyPageViewTileWidget extends StatelessWidget {

  final String pageViewTileImage;
  final String pageViewTileTitle;
  final String pageViewTileDescription;

  final double screenWidth;
  final double screenHeight;

  const MyPageViewTileWidget({
    super.key,
    required this.pageViewTileImage,
    required this.pageViewTileTitle,
    required this.pageViewTileDescription,

    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context){
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
            SvgPicture.asset(
              pageViewTileImage,
              width: screenWidth - 100,
            ),
        
            SizedBox( height : screenHeight * .06),
            Text(
              pageViewTileTitle,
              textAlign: TextAlign.center,
              style : GoogleFonts.poppins(
                fontSize : 28,
                fontWeight: FontWeight.w700,
              ),
            ),
        
            SizedBox( height : screenHeight * .04),
            Text(
              pageViewTileDescription,
              textAlign: TextAlign.center,
              style : GoogleFonts.poppins(
                fontSize : 16,
                color : ColorPalette.grey
              ),
            )
          ]
        ),
      ),
    );
  }
}