import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class EnvelopeContentsPage extends StatelessWidget {
  final String envelopeNoteName;
  final String envelopeNoteContent;
  final String envelopeNoteUsername;
  final String formattedDateTime;
 
  final void Function()? deleteNoteFunction;

  const EnvelopeContentsPage({
    required this.envelopeNoteName,
    required this.envelopeNoteContent,
    required this.envelopeNoteUsername,
    required this.formattedDateTime,
    required this.deleteNoteFunction,
    super.key
    });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar : AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: GestureDetector(
              onTap: deleteNoteFunction,
              child: Icon(FeatherIcons.trash2,
              color: ColorPalette.rustic,
              size: 26,),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20.h,
          horizontal: 14.w
          ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              envelopeNoteName,
              style: GoogleFonts.poppins(
                fontSize: 30.sp,
                fontWeight: FontWeight.w600,
              )
            ),
            SizedBox(
              height: 22.h,
              child: Row(
                children: [
                  Text(
                    formattedDateTime,
                    style: GoogleFonts.poppins(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: ColorPalette.grey
                    )
                  ),
                  VerticalDivider(
                    thickness: 3,
                    color: ColorPalette.rustic,
                    width: 22.w,
                    indent: 2,
                    endIndent: 2,
                  ),
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
                      envelopeNoteUsername,
                      style: GoogleFonts.poppins(
                        color: ColorPalette.white,
                        fontSize: 12.sp
                      ),
                     ),
                  )
                ],
              ),
            ),
            SizedBox( height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                 envelopeNoteContent,
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                  )
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}