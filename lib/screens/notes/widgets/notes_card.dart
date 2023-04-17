import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class NotesCard extends StatelessWidget {
  final double width;

  final String title;
  final String content;
  final String dateCreated;
  final String userName;


  const NotesCard({
    required this.width,
    required this.content,
    required this.title,
    required this.dateCreated,
    required this.userName,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 5.0.h),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              offset: Offset(4,4),
              blurRadius: 15.0,
              spreadRadius: 0.6
            ),
            const BoxShadow(
              color: Colors.white,
              offset: Offset(-4.0, -4.0),
             blurRadius: 15.0,
              spreadRadius: 1
            ),
          ]
        ),
        width: width,
        height: 100.h,
       padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
               title,
               style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
               ),
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    content,
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12.sp,
                    ),
                  )
                )
              ],
            ),
        SizedBox(height: 5.h,),
            
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              dateCreated,
              style: GoogleFonts.poppins(
                color: ColorPalette.rustic.shade500,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp
              ),),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 5.w,
                vertical: 2.h
                ),
              decoration: BoxDecoration(
                color: ColorPalette.murky,
                borderRadius: BorderRadius.circular(5)
              ),
              child: Text(
                userName,
                style: GoogleFonts.poppins(
                  color: ColorPalette.white,
                  fontSize: 12.sp
                ),
                  
                  ),
            )
              ],
            )
    
          ],
        )
      ),
    );
  }
}