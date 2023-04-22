import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";


class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key ? key }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            CircularProgressIndicator(
              strokeWidth: 8,
              color : ColorPalette.grey
            ),

            SizedBox(
              height : 40.h,
              width : 40.h, 
              child : CircularProgressIndicator(
                color: ColorPalette.navy,
                strokeWidth: 10,
              )
            ),

            SizedBox(
              height : 60.h,
              width : 60.h, 
              child : CircularProgressIndicator(
                color: ColorPalette.rustic,
                strokeWidth: 12,
              )
            ),

          ],
        ),
      )
    );
  }
}