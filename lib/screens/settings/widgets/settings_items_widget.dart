import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class SettingsItemsWidget extends StatelessWidget {
  final IconData prefixIcon;
  final String itemName;
  final void Function()? onTap;

  const SettingsItemsWidget({
    super.key,
    required this.prefixIcon, 
    required this.itemName, 
    required this.onTap, 
    });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children:[
            Icon(prefixIcon,
              size: 26),
            SizedBox( width: 15.w),
            Text(
              itemName,
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500
              )
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded,
              size: 24,
              color: ColorPalette.grey)
          ]
        ),
      ),
    );
  }
}