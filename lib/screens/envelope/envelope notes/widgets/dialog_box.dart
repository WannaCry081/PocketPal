import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class MyNoteDialogBoxWidget extends StatelessWidget {

  final String envelopeNoteName;
  final void Function() noteDialogBoxOnTap;

  const MyNoteDialogBoxWidget({
    required this.envelopeNoteName,
    required this.noteDialogBoxOnTap,
    super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      title: Center(
        child: Text(
          "Confirm Deletion",
          style : GoogleFonts.poppins(
            fontSize : 16.sp,
            fontWeight: FontWeight.w700
          )
        ),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text.rich(
            TextSpan(
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
              ),
              children: [
                TextSpan(
                  text: "Are you sure you want to delete "
                ),
                TextSpan(
                  text: "$envelopeNoteName",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w700,
                    color: ColorPalette.rustic,
                    fontSize: 16.sp
                  )
                ),
                TextSpan( text: " ?"),
              ]
            )
          )
        ],
      ),
      actions: [
         GestureDetector(
          onTap : () => Navigator.of(context).pop(),
          child: Text(
            "No",
            style : GoogleFonts.montserrat(
              fontWeight : FontWeight.w600,
              fontSize: 16.sp
            )
          ),
        ),
        GestureDetector(
          onTap : (){
              noteDialogBoxOnTap();
          },
          child: Text(
            "Yes", 
            style : GoogleFonts.montserrat(
              color : ColorPalette.rustic,
              fontWeight : FontWeight.w600,
              fontSize: 16.sp
            )
          ),
        )
      ],
        
    );
  }
}