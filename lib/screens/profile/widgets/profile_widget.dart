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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: ColorPalette.murky,
          backgroundImage: NetworkImage(profilePicture),
        ),
        SizedBox(height: 20.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "$profileName\n",
                style: GoogleFonts.poppins(
<<<<<<< HEAD
                  fontSize: 22.sp,
=======
                  fontSize: 20.sp,
>>>>>>> lirae-branch
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.black,
                ),
              ),
              TextSpan(text: profileEmail)
            ],
            style: GoogleFonts.poppins(
<<<<<<< HEAD
              fontSize: 16,
=======
              fontSize: 14.sp,
>>>>>>> lirae-branch
              fontWeight: FontWeight.w500,
              color: ColorPalette.grey,
              height: 1.5
            )
          ),
        ),
      ],
    );
  }
}
