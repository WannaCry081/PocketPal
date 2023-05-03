import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";

class MyProfileWidget extends StatelessWidget {
  final String profilePicture;
  final String profileName;
  final String profileEmail;

  const MyProfileWidget({
    super.key,
    required this.profilePicture,
    required this.profileName,
    required this.profileEmail
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 36.r,
          backgroundColor: ColorPalette.crimsonRed,
          backgroundImage: NetworkImage(profilePicture),
        ),
        
        SizedBox(height: 20.h),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$profileName\n",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(text: profileEmail)
            ],
            style: GoogleFonts.poppins(
              color: ColorPalette.lightGrey,
              fontSize: 12.sp,
            ),
          ),
        ),
      ],
    );
  }
}
