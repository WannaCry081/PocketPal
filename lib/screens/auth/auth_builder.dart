import "package:flutter/material.dart"; 
import "package:provider/provider.dart";

import "package:pocket_pal/screens/auth/pages/forgot_password_page.dart";
import "package:pocket_pal/screens/auth/pages/signup_page.dart";
import "package:pocket_pal/screens/auth/pages/signin_page.dart";

import "package:pocket_pal/providers/auth_provider.dart";



class AuthViewBuilder extends StatefulWidget {
  const AuthViewBuilder({ super.key });

  @override
  State<AuthViewBuilder> createState() => _AuthViewBuilderState();
}

class _AuthViewBuilderState extends State<AuthViewBuilder> {
  
  late final TextEditingController password;
  late final TextEditingController confirmPassword;

  final GlobalKey<FormState> signInFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> signUpFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  
  // sign up = -1 ; sign in = 1 ; forgot password = 0
  int _currentPage = -1;

  void changeCurrentPage(int value) => setState((){
    _currentPage = value;
    password.text = "";
    confirmPassword.text = "";

  });

  @override
  void initState(){
    super.initState();
    password = TextEditingController(text : "");
    confirmPassword = TextEditingController(text : "");
    return;
  }

  @override
  void dispose(){
    super.dispose();
    password.dispose();
    confirmPassword.dispose();
    return;
  }

  @override 
  Widget build(BuildContext context){

    final screenSize = MediaQuery.of(context).size;
    final screenHeight = screenSize.height;
    final screenWidth = screenSize.width;

    if (_currentPage == -1){
      // Sign Up Page
      return SignUpPage(
        formKey : signUpFormKey,
        screenHeight : screenHeight,
        screenWidth : screenWidth,
        changePage: changeCurrentPage,

        passwordController : password,
        confirmPasswordController : confirmPassword
      );

    } else if (_currentPage == 1){
      // Sign In Page
      return SignInPage(
        formKey : signInFormKey,
        screenHeight : screenHeight,
        screenWidth : screenWidth,
        changePage: changeCurrentPage,
      );

    } else {
      // Forgot Password Page
      return ForgotPasswordPage(
        formKey : forgotPasswordFormKey,
        screenHeight : screenHeight,
        screenWidth : screenWidth,
        changePage: changeCurrentPage,
      ); 
    }
  }
}