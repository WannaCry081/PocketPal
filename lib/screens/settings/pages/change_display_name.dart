import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';

class ChangeDisplayNameView extends StatefulWidget {

  const ChangeDisplayNameView({
    super.key,});

  @override
  State<ChangeDisplayNameView> createState() => _ChangeDisplayNameViewState();
}

class _ChangeDisplayNameViewState extends State<ChangeDisplayNameView> {

  @override
  Widget build(BuildContext context) {
    
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child: SafeArea(
          child: Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04
                ),
                child: GestureDetector(
                  onTap : (){ },
                  child : Center(
                    child : Icon(
                      Icons.arrow_back_ios_new_rounded, 
                      color : ColorPalette.rustic,
                      size : 30
                    )
                  )
                ),
              ),

              Text(
                "Change display name",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w500
                )
              )
            ],
          )
        ),
      ),

      body: SafeArea(
        child: Center(
          child: Form(
            child: SizedBox(
              width: screenWidth - (screenWidth * 0.16),
              child: Column(
                children: [
                  SizedBox (height: screenHeight * 0.03),
                  TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Current",
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 17,
                          color: ColorPalette.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: "shielamae_",
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16,
                          color: ColorPalette.grey,
                        ),
                        
                      )
                    ),

                  SizedBox (height: screenHeight * 0.025),
                  
                  PocketPalFormField(
                    formHintText: "Enter new display name",
                  ),
                  
                  const Spacer(),

                  PocketPalButton(
                    buttonOnTap: (){},
                     buttonWidth: screenWidth, 
                     buttonHeight: 60, 
                     buttonColor: ColorPalette.rustic, 
                     buttonBorderRadius: 10, 
                     buttonChild: Text(
                        "Save Changes",
                        style : GoogleFonts.poppins(
                          fontSize : 18,
                          fontWeight : FontWeight.w700,
                          color : ColorPalette.white
                        )
                      ),),

                   SizedBox (height: screenHeight * 0.04),
                  
                ],
              ) 
            )
          ),
        )
      )
    );
  }
}