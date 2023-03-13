import "package:flutter/material.dart"; 

import "package:pocket_pal/screens/auth/pages/forgot_password_template.dart";
import "package:pocket_pal/screens/auth/pages/signup_template.dart";
import "package:pocket_pal/screens/auth/pages/signin_template.dart";



class AuthViewBuilder extends StatefulWidget {
  const AuthViewBuilder({ super.key });

  @override
  State<AuthViewBuilder> createState() => _AuthViewBuilderState();
}

class _AuthViewBuilderState extends State<AuthViewBuilder> {
  
  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  
  // sign up = -1 ; sign in = 1 ; forgot password = 0
  int _currentPage = -1;

  void changeCurrentPage(int value) => setState((){
    _currentPage = value;
  });

  @override 
  Widget build(BuildContext context){

    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    if (_currentPage == -1){
      // Sign Up Template
      return SignUpTemplate(
        formKey : signUpFormKey,
        screenHeight : screenHeight,
        screenWidth : screenWidth,
        changePage: changeCurrentPage,
      );

    } else if (_currentPage == 1){
      // Sign In Template
      return SignInTemplate(
        formKey : signInFormKey,
        screenHeight : screenHeight,
        screenWidth : screenWidth,
        changePage: changeCurrentPage,
      );

    } else {
      // Forgot Password Template
      return ForgotPasswordTemplate(
        formKey : forgotPasswordFormKey,
        screenHeight : screenHeight,
        screenWidth : screenWidth,
        changePage: changeCurrentPage,
      ); 
    }
  }
}