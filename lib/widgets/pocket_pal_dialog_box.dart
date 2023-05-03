import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";


class PocketPalDialogBox extends StatelessWidget {

  final String pocketPalDialogTitle;
  final String pocketPalDialogMessage;
  final String pocketPalDialogOption1;
  final String pocketPalDialogOption2;

  final void Function() ? pocketPalDialogOption1OnTap;
  final void Function() ? pocketPalDialogOption2OnTap;

  const PocketPalDialogBox({ 
    Key ? key,
    required this.pocketPalDialogTitle, 
    required this.pocketPalDialogMessage, 
    required this.pocketPalDialogOption1, 
    required this.pocketPalDialogOption2, 

    this.pocketPalDialogOption1OnTap,
    this.pocketPalDialogOption2OnTap,
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title : Text(
        pocketPalDialogTitle,
        style : GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          color : ColorPalette.crimsonRed
        )
      ),
      content : Text(
        pocketPalDialogMessage,
        style : GoogleFonts.montserrat(
          fontSize: 14.sp
        )
      ),
      actions : [
        GestureDetector(
          onTap : pocketPalDialogOption1OnTap,
          child : Text(
            pocketPalDialogOption1,
            style : GoogleFonts.poppins(
              fontWeight : FontWeight.w500,
              fontSize : 14.sp
            )
          )
        ),

        GestureDetector(
          onTap : pocketPalDialogOption2OnTap, 
          child : Text(
            pocketPalDialogOption2,
            style : GoogleFonts.poppins(
              color : ColorPalette.crimsonRed,
              fontWeight : FontWeight.w500,
              fontSize : 14.sp
            )
          )
        )
      ]
    );
  }
}