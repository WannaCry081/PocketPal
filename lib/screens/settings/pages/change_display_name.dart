import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/services/authentication_service.dart';
import 'package:pocket_pal/widgets/pocket_pal_button.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';
import 'package:pocket_pal/widgets/pocket_pal_success_prompt.dart';

class ChangeDisplayNameView extends StatefulWidget {

  const ChangeDisplayNameView({
    super.key,});

  @override
  State<ChangeDisplayNameView> createState() => _ChangeDisplayNameViewState();
}

class _ChangeDisplayNameViewState extends State<ChangeDisplayNameView> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _newName = TextEditingController(text : "");

  @override
  void dispose(){
    super.dispose();
    _newName.dispose();
    return;
  }

  @override
  Widget build(BuildContext context) {
    
    final auth = PocketPalAuthentication();
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar : AppBar(
        title: titleText(
          "Change Display Name",
          titleSize: 18.sp,
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
                  TextFormField(
                      enabled: false,
                      decoration: InputDecoration(
                        labelText: "Current",
                        labelStyle: GoogleFonts.poppins(
                          fontSize: 17.sp,
                          color: ColorPalette.grey,
                          fontWeight: FontWeight.w600,
                        ),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        hintText: auth.getUserDisplayName,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 16.sp,
                          color: ColorPalette.grey,
                        ),
                        
                      )
                    ),
                  SizedBox (height: screenHeight * 0.025),
                  PocketPalFormField(
                    formController: _newName,
                    formHintText: "Enter new display name",
                    formValidator: (value){
                      if (value == null && value!.isEmpty ){
                        return "Please enter a User Name";
                      } else if (value.length < 4){
                        return "Please enter a valid User Name";
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

                        auth.authenticationUpdateDisplayName(
                          _newName.text.trim()
                        );

                        showDialog(
                          context: context, 
                          builder : (context){
                            return const PocketPalSuccessPrompt(
                              pocketPalSuccessTitle: "Successfully Updated!",
                              pocketPalSuccessMessage: "Your username has been updated successfully",
                            );
                          }
                        );
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
                ],
              ) 
            )
          ),
        )
      )
    );
  }
}