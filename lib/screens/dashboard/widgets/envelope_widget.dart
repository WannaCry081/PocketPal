import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:pocket_pal/utils/envelope_structure_util.dart";


class MyEnvelopeWidget extends StatelessWidget {
  final Envelope envelope;
  final double envelopeSize;
  final double envelopeTitleSize;
  final void Function() ? envelopeOnTap;
  final void Function() ? envelopeOnLongPress;

  const MyEnvelopeWidget({ 
    super.key, 
    this.envelopeSize = 160, 
    this.envelopeTitleSize = 14,
    required this.envelope,
    this.envelopeOnLongPress,
    this.envelopeOnTap,
  });

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: envelopeOnTap,
      onLongPress: envelopeOnLongPress,
      child: Stack(
        alignment : Alignment.center,
        children : [  
          SvgPicture.asset(
            "assets/icon/Envelope.svg",
            width : envelopeSize.w, 
            height : envelopeSize.h
          ),
          
          Positioned(
            bottom : 0,
            child : Text(
              envelope.envelopeName, 
              style : GoogleFonts.montserrat(
                fontSize : envelopeTitleSize.sp,
                fontWeight: FontWeight.w600
              )
            )
          )
        ]
      ),  
    );
  }
}