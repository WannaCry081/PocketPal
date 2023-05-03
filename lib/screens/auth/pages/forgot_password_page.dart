import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/widgets/pocket_pal_button.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";

import "package:pocket_pal/screens/auth/widgets/auth_title.dart";
import "package:pocket_pal/screens/auth/widgets/dialog_box.dart";
import "package:pocket_pal/services/authentication_service.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/utils/password_checker_util.dart";
import "package:pocket_pal/providers/settings_provider.dart";

class ForgotPasswordPage extends StatefulWidget { 
  const ForgotPasswordPage({ Key ? key }) : super(key : key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}


class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  
  bool _isButtonEnable = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController( text : "");

  @override
  void initState(){
    super.initState();
    _email.addListener(_textEditingControllerListener);
    return;
  }
  @override
  void dispose(){
    super.dispose();
    _email.dispose();
    return;
  }
  @override
  Widget build(BuildContext context){

    final wSettings = context.watch<SettingsProvider>();
    final rSettings = context.read<SettingsProvider>();

    return Scaffold(
      appBar : AppBar(),

      body : SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key : _formKey,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.h,
                  vertical: 20.h
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children : [
                    SvgPicture.asset(
                      "assets/svg/forgot_password.svg",
                      width : 280.w,
                      height : 280.h
                    ),

                    SizedBox(height : 20.h),

                    MyAuthTitleWidget(
                      authTitleTitle: "Forgot Password?", 
                      authTitleMessage: "Enter your email below to receive instructions in retrieving your account.",
                      authTitleTitleSize: 30.sp,
                      authTitleTitleMessageSize: 14.sp,
                    ),

                    SizedBox( height : 10.h),
                    SizedBox(
                      height : 50.h,
                      child: PocketPalFormField(
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
                    ),

                    SizedBox( height : 14.h),
                    PocketPalButton(
                      buttonOnTap: (!_isButtonEnable)? null : (){
                        if (_formKey.currentState!.validate()){
                          _formKey.currentState!.save();

                          if (wSettings.getIsFirstInstall){
                            rSettings.setIsFirstInstall(
                              !wSettings.getIsFirstInstall
                            );
                          }
                          _forgotPasswordPageResetPassword();
                          Navigator.of(context).pop();
                        }
                      }, 
                      buttonWidth: double.infinity, 
                      buttonHeight: 50.h, 
                      buttonColor: (!_isButtonEnable) ?
                        ColorPalette.black :
                        ColorPalette.crimsonRed, 
                      buttonChild: bodyText(
                        "Submit",
                        bodySize : 16.sp,
                        bodyWeight : FontWeight.w600,
                        bodyColor : ColorPalette.white
                        
                      )
                    )
                  ]
                ),
              ),
            ),
          ),
        ),
      )
    );
  }

  void _textEditingControllerListener() => setState((){
    _isButtonEnable = _email.text.isNotEmpty;
  });

  Future<void> _forgotPasswordPageResetPassword() async{
    
    try {
      await PocketPalAuthentication()
              .authenticationResetPassword(
                _email.text.trim()
              );
    } on FirebaseAuthException catch (e){
      showDialog(
        context : context,
        builder: (context) {
          return const MyDialogBoxWidget(
            dialogBoxTitle: "User Not Found",
            dialogBoxDescription: "User doesn't Exists. Please check your email and try again."
          );
        },
      );
    }
    return;
  }

}