import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class MyProfileWidget extends StatelessWidget{

  final String imagePath;
  final String nickname;
  final String profileName;

  const MyProfileWidget ({
    super.key,
    this.imagePath = "",
    required this.profileName,
    required this.nickname,
    });
  
  @override
  Widget build(BuildContext context){
    return Column(
      children: [
        CircleAvatar(
          radius: 55,
          backgroundColor: ColorPalette.murky,
          backgroundImage: AssetImage(imagePath)
        ),

        const SizedBox(height: 15,),

        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: [
              TextSpan(
                text: "$profileName\n",
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: ColorPalette.black,
                )
              ),
              TextSpan(
                text: nickname
              )
            ],
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: ColorPalette.grey,
              height: 1.5
            )
          )
        ),
       
      ],
    );
  }
}