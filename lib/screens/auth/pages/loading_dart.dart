import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

import "package:pocket_pal/const/color_palette.dart";


class LoadingPage extends StatelessWidget {
  const LoadingPage({ Key ? key }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child : SpinKitWanderingCubes(
          color : ColorPalette.crimsonRed,
          size : 60.h
        )
      )
    );
  }
}