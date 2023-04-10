import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";


class MySearchBarWidget extends StatelessWidget {
  const MySearchBarWidget({ super.key });

  @override 
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(
        vertical : 10.h, 
        horizontal: 14.w
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color : Colors.transparent,
        boxShadow: [
          BoxShadow(
            color : ColorPalette.black!.withOpacity(.2),
            blurRadius: 4,
            offset: const Offset(0, 2), 

          )
        ]
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(
            horizontal: 14.w,
            vertical : 18.h
          ),
          prefixIcon: const Icon(
            FeatherIcons.search
          ),
          filled: true,
          fillColor: ColorPalette.white,
          hintText: "Search Group | Wall | Envelope",
          hintStyle: GoogleFonts.poppins(
            fontSize : 14.sp,
            fontWeight: FontWeight.w500
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.transparent)
          ),
    
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(100),
            borderSide: const BorderSide(color: Colors.transparent)
          )
        ),
      ),
    ); 
  }
}