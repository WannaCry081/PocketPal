import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pocket_pal/const/color_palette.dart";


class MyCardWidget extends StatelessWidget {
  const MyCardWidget({ Key ? key }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Container(
      height : 160.h,
      width : double.infinity,
      margin : EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 10.h
      ),

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.r),
        color : ColorPalette.rustic
      ),
    );
  }
}