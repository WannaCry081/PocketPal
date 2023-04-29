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
            SizedBox(
              height : 100.h,
              width: 100.h,

              child: CircleAvatar(
                backgroundColor: ColorPalette.lightGrey,
              ),
            ),

            CircularProgressIndicator(
              strokeWidth: 10,
              color : ColorPalette.grey
            ),

            SizedBox(
              height : 60.h,
              width : 60.h, 
              child : CircularProgressIndicator(
                color: ColorPalette.navy,
                strokeWidth: 8,
              )
            ),

            SizedBox(
              height : 80.h,
              width : 80.h, 
              child : CircularProgressIndicator(
                color: ColorPalette.rustic,
                strokeWidth: 10,
              )
            ),

          ],
        ),
      )
    );
  }
}