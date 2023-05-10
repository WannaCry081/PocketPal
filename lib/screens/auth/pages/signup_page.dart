import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:pocket_pal/services/database_service.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/providers/user_provider.dart";
import 'package:pocket_pal/utils/pal_user_util.dart';
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/screens/auth/widgets/auth_title.dart";
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
  final List<bool> _isObsecure = [true, true];

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

    _name.removeListener(_textEditingControllerListener);
    _email.removeListener(_textEditingControllerListener);
    _password.removeListener(_textEditingControllerListener);
    _confirmPassword.removeListener(_textEditingControllerListener);

    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmPassword.dispose();
    return;
  }
  
  @override
  Widget build(BuildContext context){
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        return Consumer<UserProvider>(
          builder: (context, userProvider, child) {
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
                              authTitleTitle: "Start Saving Now!",
                              authTitleMessage: "Sign up and get started to finance\nyour expenses. Join our community today.",
                              authTitleTitleSize: 30.sp,
                              authTitleTitleMessageSize: 14.sp,
                            ),
            
                            SizedBox( height : 32.h),
            
                            SizedBox(
                              height : 50.h,
                              child: PocketPalFormField(
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
                            ),
            
                            SizedBox( height : 10.h ),
                            SizedBox(
                              height : 50.h,
                              child: PocketPalFormField(
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
                            ),
            
                            SizedBox( height : 10.h ),
                            SizedBox(
                              height : 50.h,
                              child: PocketPalFormField(
                                formController: _password,
                                formIsObsecure: _isObsecure[0],
                                formHintText: "Password",
                                formSuffixIcon: IconButton(
                                  icon : Icon(
                                    (_isObsecure[0]) ?
                                      FeatherIcons.eye :
                                      FeatherIcons.eyeOff,
                                  ),
                                  onPressed: () => setState(() => _isObsecure[0] = !_isObsecure[0]),
                                ),
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
                            ),
            
                            SizedBox( height : 10.h ),
                            SizedBox(
                              height : 50.h,
                              child: PocketPalFormField(
                                formController: _confirmPassword,
                                formIsObsecure: _isObsecure[1],
                                formHintText: "Confirm Password",
                                formSuffixIcon: IconButton(
                                  icon : Icon(
                                    (_isObsecure[1]) ?
                                      FeatherIcons.eye :
                                      FeatherIcons.eyeOff,
                                  ),
                                  onPressed: () => setState(() => _isObsecure[1] = !_isObsecure[1]),
                                ),
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
                            ),
                            SizedBox( height : 50.h),
                            PocketPalButton(
                              buttonOnTap: (!_isButtonEnable) ? null : (){
                                if (_formKey.currentState!.validate()){
                                  _formKey.currentState!.save();
                                  
                                  _signUpPageEmailAndPasswordAuth(userProvider);
                                  if (settingsProvider.getIsFirstInstall){
                                    settingsProvider.setIsFirstInstall(
                                      !settingsProvider.getIsFirstInstall
                                    );
                                  }
                                }
                              }, 
                              buttonWidth: double.infinity, 
                              buttonHeight: 50.h, 
                              buttonColor: (!_isButtonEnable) ? 
                                ColorPalette.black :
                                ColorPalette.crimsonRed,
                              buttonChild: bodyText(
                                "Sign Up",
                                bodySize : 16.sp,
                                bodyWeight : FontWeight.w600,
                                bodyColor : ColorPalette.white
                              )
                            ),
            
                            SizedBox(height : 18.h),
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
        );
      }
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

  Future<void> _signUpPageEmailAndPasswordAuth(UserProvider userProvider) async {
    try {
      await PocketPalAuthentication().authenticationSignUpEmailAndPassword(
        _name.text.trim(), 
        _email.text.trim(), 
        _password.text.trim()
      );

      await userProvider.addUserCredential(
        PalUser(
          palUserName: _name.text.trim(), 
          palUserEmail: _email.text.trim()
        ).toMap()
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