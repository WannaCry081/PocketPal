import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_fonts/google_fonts.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/screens/auth/pages/forgot_password_page.dart";
import "package:pocket_pal/screens/auth/widgets/dialog_box.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/screens/auth/widgets/bottom_hyperlink.dart";

import "package:pocket_pal/screens/auth/widgets/auth_title.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";
import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/utils/password_checker_util.dart";


class SignInPage extends StatefulWidget {

  final void Function() ? changeStateIsFirstInstall;

  const SignInPage({ 
    Key ? key,
    required this.changeStateIsFirstInstall 
  }) : super(key : key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}


class _SignInPageState extends State<SignInPage>{

  bool _isButtonEnable = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _email = TextEditingController(text : "");
  final TextEditingController _password = TextEditingController(text : "");

  @override
  void initState(){
    super.initState();
    _email.addListener(_textEditingControllerListener);
    _password.addListener(_textEditingControllerListener);
    return;
  }

  @override
  void dispose(){
    super.dispose();
    _email.dispose();
    _password.dispose();
    return;
  }
  
  @override
  Widget build(BuildContext context){

    final wSettings = context.watch<SettingsProvider>();
    final rSettings = context.read<SettingsProvider>();

    return Scaffold(
      body : SafeArea(
        child: Center(
          child : SingleChildScrollView(
            child : Form(
              key : _formKey, 
              child : Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 20.h,
                  horizontal: 16.w
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children : [
                    MyAuthTitleWidget(
                      authTitleTitle: "Welcome Back!",
                      authTitleMessage: "You've been missed!",
                      authTitleTitleSize: 28.sp,
                      authTitleTitleMessageSize: 16.sp,
                    ),

                    SizedBox( height : 40.h),
                    PocketPalFormField(
                      formController: _email,
                      formHintText: "Email Address",
                      formValidator: (value){
                        if (value == null || value.isEmpty){
                          return "Please enter an Email Address";
                        } else if (!isEmailAddress(value)) {
                          return "Please enter a valid Email Address";
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox( height : 20.h ),
                    PocketPalFormField(
                      formController: _password,
                      formIsObsecure: true,
                      formHintText: "Password",
                      formValidator: (value){
                        if (value == null || value.isEmpty){
                          return "Please enter your password";
                        } else if (value.length < 8){
                          return "Password must be at least 8 characters long";
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox( height : 14.h),
                    GestureDetector(
                      onTap : _navigateToForgotPassword,
                      child: Text(
                        "ForgotPassword?",
                        textAlign: TextAlign.end,
                        style : GoogleFonts.poppins(
                          fontSize : 12.sp,
                        )
                      ),
                    ),

                    SizedBox( height : 36.h),
                    PocketPalButton(
                      buttonOnTap: (!_isButtonEnable) ? null : (){
                        if (_formKey.currentState!.validate()){
                          _formKey.currentState!.save();
                          
                          if (wSettings.getIsFirstInstall){
                            rSettings.setIsFirstInstall(
                              !wSettings.getIsFirstInstall
                            );
                          }
                          _signInPageEmailAndPasswordAuth();
                        }
                      }, 
                      buttonWidth: double.infinity, 
                      buttonHeight: 50.h, 
                      buttonColor: (!_isButtonEnable) ? 
                        ColorPalette.black :
                        ColorPalette.rustic,
                      buttonChild: Text(
                        "Sign In",
                        style : GoogleFonts.poppins(
                          fontSize : 14.sp,
                          fontWeight : FontWeight.w500,
                          color : ColorPalette.white, 
                        )
                      )
                    ),

                    SizedBox( height : 20.h ),
                    _signInDivider(),

                    SizedBox( height : 20.h ),
                    PocketPalButton(
                      buttonOnTap: (){
                        if (wSettings.getIsFirstInstall){
                          rSettings.setIsFirstInstall(
                            !wSettings.getIsFirstInstall
                          );
                        }
                        _signInPageGoogleAuth();
                      }, 
                      buttonWidth: double.infinity, 
                      buttonHeight: 50.h, 
                      buttonColor: ColorPalette.lightGrey, 
                      buttonChild: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children :[
                          SvgPicture.asset(
                            "assets/icon/Google.svg"
                          ),

                          SizedBox( width : 10.w),
                          Text(
                            "Continue with Google",
                            style : GoogleFonts.poppins(
                              fontSize : 14.sp,
                              color : ColorPalette.black,
                              fontWeight: FontWeight.w500
                            )
                          )
                        ]
                      )
                    ),

                    SizedBox(height : 14.h),
                    MyBottomHyperlinkWidget(
                      hyperlinkOnTap: widget.changeStateIsFirstInstall, 
                      hyperlinkText: "Don't have an account? ", 
                      hyperlinkLink: "Sign Up"
                    )
                  ]
                ),
              )
            )
          )
        ),
      )
    );
  }

  Widget _signInDivider(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children : [
        Expanded(
          child : Divider(
            color : ColorPalette.grey
          ),
        ),
    
        SizedBox( width : 10.w),
        Text(
          "or signin with",
          style : GoogleFonts.poppins(
            color : ColorPalette.grey,
            fontSize : 12.sp,
          )
        ),  
    
        SizedBox( width : 10.w ),
        Expanded(
          child : Divider(
            color : ColorPalette.grey
          ),
        ),
      ]
    );
  }

  void _textEditingControllerListener(){
    setState((){
      _isButtonEnable = (_email.text.isNotEmpty && 
                        _password.text.isNotEmpty);
    });
    return;
  }

  Future<void> _signInPageGoogleAuth() async {
    await PocketPalAuthentication()
            .authenticationGoogle();
    return;
  }

  Future<void> _signInPageEmailAndPasswordAuth() async {
    try {
      await PocketPalAuthentication()
              .authenticationSignInEmailAndPassword(
                _email.text.trim(),
                _password.text.trim()
              );
    } on FirebaseAuthException catch (e){
      showDialog(
        context : context,
        builder :(context) {
          return MyDialogBoxWidget(
            dialogBoxTitle: (e.code == "user-not-found") ? 
              "User Not Found" : 
                (e.code == "wrong-password") ?
                  "Wrong Password" : 
                  "System Error",
            dialogBoxDescription: (e.code == "user-not-found") ? 
              "User doesn't Exists. Please check your email and try again." : 
                (e.code == "wrong-password") ?
                  "Invalid password. Please check your password and try again." : 
                  "Please enter a valid Email Address and Password.",
          );
        },
      );
    }
    return;
  }

  void _navigateToForgotPassword(){
    Navigator.of(context).push(
      MaterialPageRoute(
        builder : (context) => const ForgotPasswordPage()
      )
    );
    _email.clear();
    _password.clear();
    return;
  }
}