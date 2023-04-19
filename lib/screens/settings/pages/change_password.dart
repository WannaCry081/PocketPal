import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
       appBar: AppBar(
        title: Text(
          "Change Password",
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