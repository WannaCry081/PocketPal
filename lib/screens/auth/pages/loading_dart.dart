import "package:flutter/material.dart";
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_pal/const/color_palette.dart';


class LoadingPage extends StatelessWidget {
  const LoadingPage({ super.key });

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              height: 80.h,
              width: 80.w,
              child: CircularProgressIndicator(
                backgroundColor: ColorPalette.rustic.shade100,
                strokeWidth: 8,
              ),
            ),
            SizedBox(
              height: 60.h,
              width: 60.w,
              child: CircularProgressIndicator(
                backgroundColor: ColorPalette.navy.shade100,
                color: ColorPalette.navy,
                strokeWidth: 7,
              ),
            ),
            SizedBox(
              height: 40.h,
              width: 40.w,
              child: CircularProgressIndicator(
                backgroundColor: ColorPalette.murky.shade100,
                color: ColorPalette.murky,
                strokeWidth: 6,
              ),
            ),
          ],
        ),
      )
    );
  }
}