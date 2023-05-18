import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


class PocketPalDialogBox extends StatelessWidget {

  final String pocketPalDialogTitle;
  final Widget ? pocketPalDialogContent;
  final String pocketPalDialogOption1;
  final String pocketPalDialogOption2;

  final void Function() ? pocketPalDialogOption1OnTap;
  final void Function() ? pocketPalDialogOption2OnTap;

  const PocketPalDialogBox({ 
    Key ? key,
    required this.pocketPalDialogTitle, 
    required this.pocketPalDialogContent, 
    required this.pocketPalDialogOption1, 
    required this.pocketPalDialogOption2, 

    this.pocketPalDialogOption1OnTap,
    this.pocketPalDialogOption2OnTap,
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      title : titleText(
        pocketPalDialogTitle,
        titleWeight: FontWeight.w600,
        titleColor : ColorPalette.crimsonRed
      ),
      content : pocketPalDialogContent,
      actions : [
        GestureDetector(
          onTap : pocketPalDialogOption1OnTap,
          child : bodyText(
            pocketPalDialogOption1,
            bodyWeight : FontWeight.w500,
            bodySize : 16.sp,
          )
        ),

        GestureDetector(
          onTap : pocketPalDialogOption2OnTap, 
          child : bodyText(
            pocketPalDialogOption2,
            bodyColor : ColorPalette.crimsonRed,
            bodyWeight : FontWeight.w500,
            bodySize : 16.sp
          )
        )
      ]
    );
  }
}