import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/utils/envelope_util.dart";



class PocketPalEnvelope extends StatelessWidget {
  
  final Envelope envelope;
  final void Function() ? envelopeOpenContents;
  final void Function() ? envelopeEditContents;

  const PocketPalEnvelope({ 
    Key ? key,
    required this.envelope,
    this.envelopeOpenContents,
    this.envelopeEditContents
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap : envelopeOpenContents,
      onLongPress : envelopeEditContents,
      child: Container(
        width : 140.w,
        height : 160.h + 20.w,
        decoration : BoxDecoration(
          borderRadius: BorderRadius.circular(30.r),
          color : ColorPalette.salmonPink[50]
        ),
        child : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children : [
    
            SvgPicture.asset(
              "assets/icon/Envelope.svg",
              width : 90.h,
              height : 90.h
            ),
    
            SizedBox( height : 8.h ), 
    
            SizedBox(
              width : 100.w,
              child: Center(
                child: titleText(
                  envelope.envelopeName,
                  titleOverflow: TextOverflow.ellipsis,
                  titleWeight: FontWeight.w600,
                  titleSize : 14.sp,
                ),
              ),
            ),

            SizedBox( height : 2.h ), 
            bodyText( 
              "${envelope.envelopeDate.month}/${envelope.envelopeDate.day}/${envelope.envelopeDate.year}",
              bodySize : 12.sp,
              bodyColor: ColorPalette.grey
            )
  
          ]
        )
      ),
    );
  }
}