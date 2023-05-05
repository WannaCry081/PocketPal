import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/auth/auth_builder.dart';
import 'package:pocket_pal/services/authentication_service.dart';
// import 'package:pocket_pal/screens/auth/widgets/password_bottom_sheet_widget.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';
import 'package:pocket_pal/widgets/pocket_pal_success_prompt.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _oldPass = TextEditingController(text : "");
  final TextEditingController _newPass = TextEditingController(text : "");
  final TextEditingController _confirmNewPass = TextEditingController(text : "");

  final List<bool> _isObsecure = [true, true, true];

  @override
  void dispose(){
    super.dispose();
    _oldPass.dispose();
    _newPass.dispose();
    _confirmNewPass.dispose();
    return;
  }
  @override
  Widget build(BuildContext context) {

    final auth = PocketPalAuthentication();

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
            key : _formKey, 
            child: SizedBox(
              width: screenWidth - (screenWidth * 0.10),
              child: Column(
                children: [
                  SizedBox (height: screenHeight * 0.03),
                  PocketPalFormField(
                    formController: _oldPass,
                    formHintText: "Current Password",
                    formIsObsecure: _isObsecure[0],
                    formSuffixIcon: IconButton(
                      icon :Icon(
                          _isObsecure[0] ? 
                            FeatherIcons.eye :
                            FeatherIcons.eyeOff
                        ),  
                      onPressed: () => _showPassword(0),
                    ),
                    formValidator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox (height: screenHeight * 0.025),
                  PocketPalFormField(
                    formController: _newPass,
                    formHintText: "Enter New Password",
                    formIsObsecure: _isObsecure[1],
                    formSuffixIcon: IconButton(
                      icon : Icon(
                          _isObsecure[1] ? 
                            FeatherIcons.eye :
                            FeatherIcons.eyeOff
                        ), 
                      onPressed: () => _showPassword(1),
                    ),
                    formValidator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your New Password";
                      } else if (value.length < 8) { 
                          return "Password must at least be 8 characters long";
                        } else {
                        return null;
                      }
                    },
                  ),

                  SizedBox (height: screenHeight * 0.025),

                  PocketPalFormField(
                    formController: _confirmNewPass,
                    formHintText: "Confirm New Password",
                    formIsObsecure: _isObsecure[2],
                    formSuffixIcon: IconButton(
                      icon : Icon(
                          _isObsecure[2] ? 
                            FeatherIcons.eye :
                            FeatherIcons.eyeOff
                        ),  
                      onPressed: () => _showPassword(2),
                    ),
                    formValidator: (value){
                      if (value == null || value.isEmpty){
                        return "Please enter your New Password";
                      } else if (_newPass.text != value) { 
                        return "Password does not Match";
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox (height: screenHeight * 0.03),
                  PocketPalButton(
                    buttonOnTap: (){
                      if (_formKey.currentState!.validate()){
                        _formKey.currentState!.save();

                        try {
                          auth.authenticationChangePassword(
                            _oldPass.text.trim(),
                            _newPass.text.trim()
                          );

                          showDialog(
                            context : context,
                            builder: (context){
                              return const PocketPalSuccessPrompt(
                                pocketPalSuccessTitle: "Successfully Changed!", 
                                pocketPalSuccessMessage: "Your password has been successfully changed!"
                              );
                            }
                          );
                        } catch (e){
                        }
                      }
                    },
                     buttonWidth: screenWidth, 
                     buttonHeight: 50.h, 
                     buttonColor: ColorPalette.crimsonRed, 
                     buttonBorderRadius: 10, 
                     buttonChild: bodyText(
                        "Save changes",
                        bodySize : 16.sp,
                        bodyWeight : FontWeight.w600,
                        bodyColor : ColorPalette.white
                      )
                    ),

                  SizedBox (height: screenHeight * 0.04),
                ],
              )
            )
          )
        )
      )
    );
  }

  void _showPassword(int index) => setState((){
    _isObsecure[index] = !_isObsecure[index];
  });
}