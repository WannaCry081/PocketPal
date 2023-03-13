import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:provider/provider.dart"; 

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/widgets/pocket_pal_formfield.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";

import "package:pocket_pal/screens/auth/widgets/divider_widget.dart";
import "package:pocket_pal/screens/auth/widgets/social_auth_widget.dart";
import "package:pocket_pal/screens/auth/widgets/bottom_navigation_widget.dart";

import "package:pocket_pal/services/auth_services.dart";

import "package:pocket_pal/providers/auth_provider.dart";


class SignInTemplate extends StatelessWidget{

  final GlobalKey<FormState> formKey;
  final void Function(int) changePage;

  final double screenWidth;
  final double screenHeight;

  const SignInTemplate({ 
    super.key,
    required this.formKey,
    required this.changePage,
    required this.screenHeight,
    required this.screenWidth,
  });

  @override 
  Widget build(BuildContext context){
    
    final rAuth = context.read<AuthProvider>();
    final wAuth = context.watch<AuthProvider>();

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key : formKey,

              child: SizedBox(
                width : screenWidth - (screenWidth * 0.16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children : [
                      
                    SizedBox(height : screenHeight * .04 ),
                    RichText(
                      text : TextSpan(
                        children : [
                          TextSpan(
                            text : "Welcome Back\n",
                            style : TextStyle(
                              color : ColorPalette.black,
                              fontSize: 34,
                              fontWeight : FontWeight.w600
                            )
                          ),
                          const TextSpan(text : "You've been missed!" )
                        ],
                        style : GoogleFonts.poppins(
                          color : ColorPalette.grey,
                          fontSize : 16,
                        )
                      ),
                    ),
                  
                    SizedBox( height : screenHeight * 0.06),
                    PocketPalFormField(
                      formHintText : "Email Address",
                      formOnSaved: rAuth.setEmail,
                      formValidator: (value){
                        String pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
                        final regExp = RegExp(pattern);
      
                        if (value!.isEmpty) {
                          return "Email Address Field must not be Empty";
                        } else if (!regExp.hasMatch(value)) {
                          return "Please Enter a Valid Email Address";
                        } else {
                          return null;
                        }
                      },
                    ),
                    
                    SizedBox( height : screenHeight * 0.02 ),
                    PocketPalFormField(
                      formHintText : "Password",
                      formIsObsecure: wAuth.getIsObsecure,
                      formOnSaved: rAuth.setPassword,
                      formValidator: (value){
                        final fieldLength = value!.length;
                        
                        if (value.isEmpty){
                          return "Password Field must not be Empty";
                        } else if (fieldLength < 7) {
                          return "Password must be at least 7 characters long";
                        } else {
                          return null;
                        }
                      },
                      formSuffixIcon: IconButton(
                        icon : Icon(
                          (wAuth.getIsObsecure) ? 
                            FeatherIcons.eye : FeatherIcons.eyeOff
                        ), 
                        onPressed: rAuth.changeObsecure,
                      ),
                    ),
                    
                    SizedBox( height : screenHeight * 0.02 ),
                    Align(
                      alignment : Alignment.centerRight,
                      child: GestureDetector(
                        onTap : () => changePage(0),
                        child: Text(
                          "Forgot Password?",
                          style : GoogleFonts.poppins()
                        ),
                      ),
                    ),
                    
                    SizedBox( height : screenHeight * 0.02 ),
                    PocketPalButton(
                      buttonHeight: 60, 
                      buttonWidth : screenWidth,
                      buttonVerticalMargin: screenHeight * .04,
                      buttonBorderRadius: 10,
                      buttonColor: ColorPalette.rustic,
                      buttonOnTap: (){
                        final isValid = formKey.currentState!.validate();
      
                        if (isValid){
                          formKey.currentState!.save();

                          AuthFirebaseService().signInUser(
                            wAuth.getEmail.trim(),
                            wAuth.getPassword.trim()
                          );
                        }
                      },
                      buttonChild: Text(
                        "Log In",
                        style : GoogleFonts.poppins(
                          fontSize : 18,
                          fontWeight : FontWeight.w600,
                          color : ColorPalette.white
                        )
                      ),
                    ),
                    
                    SizedBox(height : screenHeight * .12 ),
                    MyDividerWidget(
                      dividerName: "or Login In with",
                      dividerWidth: screenWidth,
                    ),
              
                    SizedBox(height : screenHeight * .04 ),
                    const SocialAuthWidget(),
                  
                    SizedBox(height : screenHeight * .06 ),
                    MyBottomNavigationWidget(
                      bottomText: "Don't have an Account? ",
                      bottomNavigationText: "Sign Up",
                      bottomOnTap: () {
                        changePage(-1);
                        formKey.currentState!.reset();
                        rAuth.reset();
                      }
                    ),
                    SizedBox(height : screenHeight * .04 ),
                  ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}