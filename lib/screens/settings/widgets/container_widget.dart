import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_pal/const/color_palette.dart';

class SettingsContainerWidget extends StatelessWidget {
  final dynamic child;

  const SettingsContainerWidget({
    super.key,
    required this.child,
    });

  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      child: child,
      height: 500, 
      width: screenWidth - (screenWidth * 0.12),
      padding: EdgeInsets.only(
        top : 10.h,
        left: 14.w,
        right: 14.w
      ),
      //margin: const EdgeInsets.only (top: 45.0),
      decoration: BoxDecoration(
        color: ColorPalette.white,
        border: Border.all(
          color: ColorPalette.lightGrey!,
          width: 0.5
        ),
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
              offset: Offset(0, 4),
              spreadRadius: 0,
              blurRadius: 4,
              color: Color.fromRGBO(0, 0, 0, 0.25),
          )
        ]
      ),
    ) ;
  }
}