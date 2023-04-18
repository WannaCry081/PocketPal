import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/services/authentication_service.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';

class ChangeDisplayNameView extends StatefulWidget {

  const ChangeDisplayNameView({
    super.key,});

  @override
  State<ChangeDisplayNameView> createState() => _ChangeDisplayNameViewState();
}

class _ChangeDisplayNameViewState extends State<ChangeDisplayNameView> {

  final auth = PocketPalAuthentication();

  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar : AppBar(
        title: Text(
          "Change Display Name",
            style: GoogleFonts.poppins(
              fontSize : 18.sp,
              color: ColorPalette.black,
            ),
          ),
      ),
      body: SafeArea(
        child: Center(
          child: Form(
            child: SizedBox(
              width: screenWidth - (screenWidth * 0.10),
              child: Column(
                children: [
                  SizedBox (height: screenHeight * 0.03),
                  TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Current",
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 17.sp,
                          color: ColorPalette.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: auth.getUserDisplayName,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: ColorPalette.grey,
                        ),
                        
                      )
                    ),
                  SizedBox (height: screenHeight * 0.025),
                  const PocketPalFormField(
                    formHintText: "Enter new display name",
                  ),
                  SizedBox (height: screenHeight * 0.03),
                  PocketPalButton(
                    buttonOnTap: (){},
                     buttonWidth: screenWidth, 
                     buttonHeight: 60, 
                     buttonColor: ColorPalette.rustic, 
                     buttonBorderRadius: 10, 
                     buttonChild: Text(
                        "Save Changes",
                      style : GoogleFonts.poppins(
                        fontSize : 16.sp,
                        fontWeight : FontWeight.w700,
                        color : ColorPalette.white
                      )
                    ),),
                ],
              ) 
            )
          ),
        )
      )
    );
  }
}