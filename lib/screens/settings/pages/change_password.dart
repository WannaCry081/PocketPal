import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
// import 'package:pocket_pal/screens/auth/widgets/password_bottom_sheet_widget.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

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
                "Change password",
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

                  PocketPalFormField(
                    formHintText: "Current Password",
                    formIsObsecure: true,
                    formSuffixIcon: IconButton(
                        icon : const  Icon(
                            FeatherIcons.eye), 
                        onPressed: (){},
                      ),
                  ),

                  SizedBox (height: screenHeight * 0.025),

                  PocketPalFormField(
                    formHintText: "Enter New Password",
                    formIsObsecure: true,
                    formIsReadOnly: true,
                    formSuffixIcon: IconButton(
                        icon : const Icon(
                            FeatherIcons.eye), 
                        onPressed: (){},
                      ),
                    formOnTap: (){}
                  ),

                  SizedBox (height: screenHeight * 0.025),

                  PocketPalFormField(
                    formHintText: "Confirm New Password",
                    formIsObsecure: true,
                    formIsReadOnly: true,
                    formSuffixIcon: IconButton(
                        icon : const Icon(
                            FeatherIcons.eye), 
                        onPressed: (){},
                      ),
                    formOnTap: (){}
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
          )
        )
      )
    );
  }
}