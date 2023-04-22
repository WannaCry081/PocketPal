import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/screens/auth/widgets/auth_title.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/screens/auth/widgets/dialog_box.dart";
import "package:pocket_pal/screens/auth/widgets/bottom_hyperlink.dart";

import "package:pocket_pal/widgets/pocket_pal_button.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";

import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/providers/settings_provider.dart";
import "package:pocket_pal/utils/password_checker_util.dart";


class SignUpPage extends StatefulWidget {

  final void Function() ? changeStateIsFirstInstall;

  const SignUpPage({ 
    Key ? key,
    required this.changeStateIsFirstInstall 
  }) : super(key : key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}


class _SignUpPageState extends State<SignUpPage>{

  bool _isButtonEnable = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController(text : "");
  final TextEditingController _email = TextEditingController(text : "");
  final TextEditingController _password = TextEditingController(text : "");
  final TextEditingController _confirmPassword = TextEditingController(text : "");

  @override 
  void initState(){
    super.initState();
    _name.addListener(_textEditingControllerListener);
    _email.addListener(_textEditingControllerListener);
    _password.addListener(_textEditingControllerListener);
    _confirmPassword.addListener(_textEditingControllerListener);
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
                  horizontal: 14.w
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children : [
                    MyAuthTitleWidget(
                      authTitleTitle: "Create Account",
                      authTitleMessage: "Sign up to get Started!",
                      authTitleTitleSize: 28.sp,
                      authTitleTitleMessageSize: 16.sp,
                    ),

                    SizedBox( height : 40.h),
                    PocketPalFormField(
                      formController: _name,
                      formHintText: "Full Name",
                      formValidator: (value){
                        if (value == null || value.isEmpty){
                          return "Please enter your Full Name";
                        } else if (value.length < 4) { 
                          return "Please enter a valid Name";
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox( height : 20.h ),
                    PocketPalFormField(
                      formController: _email,
                      formHintText: "Email Address",
                      formValidator: (value){
                        if (value == null || value.isEmpty){
                          return "Please enter your Email Address";
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
                          return "Please enter a Password";
                        } else if (value.length < 8) { 
                          return "Password must at least be 8 characters long";
                        } else {
                          return null;
                        }
                      },
                    ),

                    SizedBox( height : 20.h ),
                    PocketPalFormField(
                      formController: _confirmPassword,
                      formIsObsecure: true,
                      formHintText: "Confirm Password",
                      formValidator: (value){
                        if (value == null || value.isEmpty){
                          return "Please enter your Password";
                        } else if (_password.text != value) { 
                          return "Password does not Match";
                        } else {
                          return null;
                        }
                      },
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
                          _signUpPageEmailAndPasswordAuth();
                        }
                      }, 
                      buttonWidth: double.infinity, 
                      buttonHeight: 50.h, 
                      buttonColor: (!_isButtonEnable) ? 
                        ColorPalette.black :
                        ColorPalette.rustic,
                      buttonChild: Text(
                        "Sign Up",
                        style : GoogleFonts.poppins(
                          fontSize : 14.sp,
                          fontWeight : FontWeight.w500,
                          color : ColorPalette.white
                        )
                      )
                    ),

                    SizedBox(height : 14.h),
                    MyBottomHyperlinkWidget(
                      hyperlinkOnTap: widget.changeStateIsFirstInstall, 
                      hyperlinkText: "Already have an account? ", 
                      hyperlinkLink: "Sign In"
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

  void _textEditingControllerListener(){
    setState((){
      _isButtonEnable = _name.text.isNotEmpty && 
                        _email.text.isNotEmpty &&
                        _password.text.isNotEmpty &&
                        _confirmPassword.text.isNotEmpty; 
    });
    return;
  }

  Future<void> _signUpPageEmailAndPasswordAuth() async {
    try {
      await PocketPalAuthentication().authenticationSignUpEmailAndPassword(
        _name.text.trim(), 
        _email.text.trim(), 
        _password.text.trim()
      );
    } on FirebaseAuthException catch(e){
      showDialog(
        context : context,
        builder : (context) {
          return MyDialogBoxWidget(
            dialogBoxTitle: (e.code == "email-already-in-use") ? 
              "User already Exists" : 
              "System Error", 
            dialogBoxDescription: (e.code == "email-already-in-use") ? 
              "The account already exists please enter a valid account." :
              "Invalid user credentials. Please enter a valid user information."
          );
        }
      );
    }
    return;
  }
}