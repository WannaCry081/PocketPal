import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";


class MyDividerWidget extends StatelessWidget {
  
  final String dividerName;
  final double dividerWidth; 

  const MyDividerWidget({ 
    super.key,
    required this.dividerWidth,
    required this.dividerName,
  });

  @override
  Widget build(BuildContext context){
    return SizedBox(
      width : dividerWidth,
      child: Row(
        children : [
          Expanded(
            child : Divider(
              color : ColorPalette.grey
            ),
          ),
    
          SizedBox( width : dividerWidth * 0.01 ),
          Text(
            dividerName,
            style : GoogleFonts.poppins(
              color : ColorPalette.grey,
              fontSize : 12,
            )
          ),  
    
          SizedBox( width : dividerWidth * 0.01 ),
          Expanded(
            child : Divider(
              color : ColorPalette.grey
            ),
          ),
        ]
      ),
    );
  }
}