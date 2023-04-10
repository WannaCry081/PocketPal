import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class SettingsHeaderWidget extends StatelessWidget {
  final String headerName;

  const SettingsHeaderWidget({
    super.key,
    required this.headerName
  });
  
  @override
  Widget build(BuildContext context){
    return Text(
      headerName,
      style: GoogleFonts.poppins(
        fontSize: 16.sp,
        color: ColorPalette.grey,
        fontWeight: FontWeight.w500
      ));
  }
}