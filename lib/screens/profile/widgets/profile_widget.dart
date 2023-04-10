import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";

class MyProfileWidget extends StatelessWidget {
  final String imagePath;
  final String nickname;
  final String profileName;

  const MyProfileWidget({
    Key? key,
    this.imagePath = "",
    required this.nickname,
    required this.profileName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: ColorPalette.murky,
          backgroundImage: _getImageProvider(),
        ),
        SizedBox(height: 20.h),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "$nickname\n",
                style: GoogleFonts.poppins(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.black,
                ),
              ),
              TextSpan(text: profileName)
            ],
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: ColorPalette.grey,
              height: 1.5
            )
          ),
        ),
      ],
    );
  }

  ImageProvider _getImageProvider() {
    if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
      return NetworkImage(imagePath);
    } else {
      return AssetImage(imagePath);
    }
  }
}
