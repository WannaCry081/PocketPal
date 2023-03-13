import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/widgets/pocket_pal_button.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";

import "package:pocket_pal/services/auth_services.dart";

import "package:pocket_pal/providers/auth_provider.dart";


class ForgotPasswordTemplate extends StatelessWidget{
  
  final GlobalKey<FormState> formKey;
  final void Function(int) changePage;
  
  final double screenWidth;
  final double screenHeight;

  const ForgotPasswordTemplate({ 
    super.key,
    required this.formKey, 
    required this.changePage,
    required this.screenWidth,
    required this.screenHeight,
  });

  @override 
  Widget build(BuildContext context){
    
    final rAuth = context.read<AuthProvider>();
    final wAuth = context.watch<AuthProvider>();

    return Scaffold(
      appBar : PreferredSize(
        preferredSize: Size.fromHeight(screenHeight * 0.08),
        child : SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children : [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.06
                ),
                child: GestureDetector(
                  onTap : () {
                    changePage(1);
                    formKey.currentState!.reset(); 
                  },
                  child : Center(
                    child : Icon(
                      Icons.arrow_back_ios_new_rounded, 
                      color : ColorPalette.black,
                      size : 38
                    )
                  )
                ),
              )
            ]
          ),
        )
      ),

      body : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key : formKey,
              child: SizedBox(
                width : screenWidth - (screenWidth * 0.16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children : [
                    Center(
                      child: SvgPicture.asset(
                        "assets/svg/forgot_password.svg",
                        width: screenWidth - (screenWidth * 0.08)
                      )
                    ),
                    
                    SizedBox( height : screenHeight * .04), 
                    
                    RichText(
                      text : TextSpan(
                        children : [
                          TextSpan(
                            text : "Forgot Password?\n",
                            style : TextStyle(
                              color : ColorPalette.black,
                              fontSize: 34,
                              fontWeight : FontWeight.w600
                            )
                          ),
                          const TextSpan(text : "Enter your email below to receive instructions in retrieving your account" )
                        ],
                        style : GoogleFonts.poppins(
                          color : ColorPalette.grey,
                          fontSize : 16,
                        )
                      ),
                    ),
                    
                    SizedBox( height : screenHeight * .03 ),
                    PocketPalFormField( 
                      formHintText : "Email Address",
                      formOnSaved: rAuth.setEmail,
                      formValidator: (value){
                        String pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
                        final regExp = RegExp(pattern);
      
                        if (value!.isEmpty) {
                          return "Email Address Field is Empty";
                        } else if (!regExp.hasMatch(value)) {
                          return "Please Enter a Valid Email Address";
                        } else {
                          return null;
                        }
                      },
                    ),
                    
                    SizedBox( height : screenHeight * 0.03),
                    PocketPalButton(
                      buttonHeight: 60, 
                      buttonWidth: screenWidth, 
                      buttonBorderRadius: 10,
                      buttonColor: ColorPalette.rustic, 
                      buttonOnTap: (){
                        final isValid = formKey.currentState!.validate();
      
                        if (isValid){
                          formKey.currentState!.save();

                          AuthFirebaseService().forgotPassword(
                            wAuth.getEmail.trim()
                          );

                          changePage(1);
                        }
                      },
                      buttonChild: Text(
                        "Submit",
                        style : GoogleFonts.poppins(
                          fontSize : 18,
                          fontWeight : FontWeight.w700,
                          color : ColorPalette.white
                        )
                      ),
                    ),
                    SizedBox( height : screenHeight * 0.04),
                  ]
                ),
              ),
            ),
          ),
        ),
      )
    ); 
  }
}


    