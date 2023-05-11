import "dart:async";

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/auth/auth_builder.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({ Key ? key }) : super(key : key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  @override
  void initState(){
    super.initState();
    Timer.periodic(const Duration(seconds : 4), (timer) { 
      Navigator.of(context).push(
        MaterialPageRoute(
          builder : (context) => const AuthViewBuilder()
        )
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.passthrough,
          children:[
            Positioned(
              left: 12,
              bottom: -45,
              //bottom: -MediaQuery.of(context).size.height + 2.h,
              child: SvgPicture.asset(
                  "assets/svg/welcome_doggie.svg",
                  width: MediaQuery.of(context).size.width + 25
              ),
            ),
            Positioned(
              top: 175,
              left: 75,
              child: Column(
                children: [
                 titleText(
                  "Spend smart. Track better.",
                  titleColor: ColorPalette.grey,
                  titleWeight: FontWeight.w500,
                  titleSize: 17.sp
                 ),
                  AnimatedTextKit(
                    displayFullTextOnTap: true,
                    animatedTexts: [
                      TypewriterAnimatedText(
                        "Welcome\n  to Pocket Pal!",
                        textAlign: TextAlign.center,
                        textStyle: GoogleFonts.poppins(
                            fontWeight: FontWeight.w700,
                            color: ColorPalette.crimsonRed,
                            fontSize: 30.sp,
                            height: 1.2,
                        ),
                        speed: const Duration(milliseconds: 100)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]
        ),
      )
    );
  }
}

