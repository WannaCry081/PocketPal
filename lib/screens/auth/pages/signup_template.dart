import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/screens/auth/widgets/password_bottom_sheet_widget.dart";

import "package:pocket_pal/widgets/pocket_pal_formfield.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";

import "package:pocket_pal/screens/auth/widgets/divider_widget.dart";
import "package:pocket_pal/screens/auth/widgets/social_auth_widget.dart";
import "package:pocket_pal/screens/auth/widgets/bottom_navigation_widget.dart";

import "package:pocket_pal/services/auth_services.dart";

import "package:pocket_pal/providers/auth_provider.dart";


class SignUpTemplate extends StatelessWidget{
  
  final GlobalKey<FormState> formKey;
  final void Function(int) changePage;

  final double screenWidth;
  final double screenHeight;

  const SignUpTemplate({ 
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
                            text : "Create Account\n",
                            style : TextStyle(
                              color : ColorPalette.black,
                              fontSize: 34,
                              fontWeight : FontWeight.w600
                            )
                          ),
                          const TextSpan(text : "Sign up to get started!" )
                        ],
                        style : GoogleFonts.poppins(
                          color : ColorPalette.grey,
                          fontSize : 16,
                        )
                      ),
                    ),
                  
                    SizedBox( height : screenHeight * 0.06),
                    PocketPalFormField(
                      formHintText : "Full Name",
                      formOnSaved : rAuth.setName,
                      formValidator: (value){
                        if (value!.isEmpty){
                          return "Name Field must not be Empty";
                        } else {
                          return null;
                        }
                      },
                    ),
      
                    SizedBox( height : screenHeight * 0.02),
                    PocketPalFormField(
                      formHintText : "Email Address",
                      formOnSaved : rAuth.setEmail,
                      formValidator: (value) {
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
                      formIsReadOnly: true,
                      formIsObsecure: true,
                      formOnSaved: (value) => wAuth.setPassword(value),
                      formValidator: (value) {
                        if (value!.isEmpty){
                          return "Password Field must not be Empty";
                        } else if (value != wAuth.getConfirmPassword){
                          return "Password does not Match with the confirm password";
                        } else {
                          return null;
                        }
                      },
                      formOnTap: (){
      
                        showModalBottomSheet(
                          isScrollControlled: true ,
                          context: context, 
                          builder: (context){
                            return MyPasswordBottomSheet(
                              text : wAuth.setPassword,
                              formKey: formKey,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              bottomSheetHintText: "Password",
                            );
                          }
                        );
                        
                      },
                    ),
                    
                    SizedBox( height : screenHeight * 0.02 ),
                    PocketPalFormField(
                      formHintText : "Confirm Password",
                      formIsObsecure: true,
                      formIsReadOnly: true,
                      formOnSaved: (value) => wAuth.setConfirmPassword(value),
                      formValidator: (value) {
                        if (value!.isEmpty){
                          return "Confirm Password Field must not be Empty";
                        } else if (value != wAuth.getPassword){
                          return "Confirm Password does not Match with the password";
                        } else {
                          return null;
                        }
                      },
                      formOnTap: (){

                        showModalBottomSheet(
                          isScrollControlled: true ,
                          context: context, 
                          builder: (context){
                            return MyPasswordBottomSheet(
                              formKey: formKey,
                              text : rAuth.setConfirmPassword,
                              screenHeight: screenHeight,
                              screenWidth: screenWidth,
                              bottomSheetHintText: "Confirm Password",
                            );
                          }
                        );
      
                      },
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

                          AuthFirebaseService().signUpUser(
                            wAuth.getEmail.trim(),
                            wAuth.getPassword.trim()
                          );
                        }
                      },
                      buttonChild: Text(
                        "Sign Up",
                        style : GoogleFonts.poppins(
                          fontSize : 18,
                          fontWeight : FontWeight.w600,
                          color : ColorPalette.white
                        )
                      ),
                    ),
                    
                    SizedBox(height : screenHeight * .02 ),
                    MyDividerWidget(
                      dividerName: "or Sign Up with",
                      dividerWidth: screenWidth,
                    ),
              
                    SizedBox(height : screenHeight * .04 ),
                    const SocialAuthWidget(),
                  
                    SizedBox(height : screenHeight * .06 ),
                    MyBottomNavigationWidget(
                      bottomText: "Already have an Account? ",
                      bottomNavigationText: "Log In",
                      bottomOnTap: (){
                        changePage(1);
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