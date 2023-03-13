import "package:flutter/material.dart";
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 32,
          backgroundColor: ColorPalette.rustic,
          backgroundImage: _getImageProvider(),
        ),
        const SizedBox(height: 20),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$nickname\n",
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                ),
              ),
              TextSpan(text: profileName)
            ],
            style: GoogleFonts.poppins(
              color: ColorPalette.lightGrey,
              fontSize: 15,
            ),
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
