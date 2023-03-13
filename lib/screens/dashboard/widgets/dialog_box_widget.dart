import "package:flutter/material.dart";
import "package:pocket_pal/const/color_palette.dart";


class MyDialogBoxWidget extends StatelessWidget {
  
  final double screenWidth;
  final double screenHeight;

  const MyDialogBoxWidget({ 
    super.key,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        width : screenWidth,
        height : 200,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color : ColorPalette.white
        ),
        child : Column(
          children : [

            ElevatedButton(
              child : Text("Add"),
              onPressed: (){},
            )
          ]
        )
      ),
    );
  }
}