import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:provider/provider.dart";

import "package:pocket_pal/providers/auth_provider.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class MyPasswordBottomSheet extends StatelessWidget {

  final GlobalKey<FormState> formKey;

  final double screenWidth;
  final double screenHeight;

  final String bottomSheetHintText;
  final void Function(String?) text;


  const MyPasswordBottomSheet({
    super.key,
    required this.text,
    required this.formKey,
    required this.screenHeight,
    required this.screenWidth,
    required this.bottomSheetHintText,
  });

  @override
  Widget build(BuildContext context){

    final wAuth = context.watch<AuthProvider>();
    final rAuth = context.read<AuthProvider>();

    return Padding(
      padding: EdgeInsets.only(
        top: 30,  
        right: 30,  
        left: 30,
        bottom: MediaQuery.of(context).viewInsets.bottom
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children : [
              GestureDetector(
                onTap : () {
                  Navigator.of(context).pop();
                  rAuth.reset();
                },
                child: Text(
                  "Cancel",
                  style : GoogleFonts.poppins(
                    fontSize: 16
                  )
                ),
              ),
              GestureDetector(
                onTap : (){
                  Navigator.of(context).pop();
                  formKey.currentState!.save();
                  rAuth.reset();
                },
                child: Text(
                  "Done",
                  style : GoogleFonts.poppins(
                    fontSize: 16,
                    color : ColorPalette.rustic,
                    fontWeight: FontWeight.w600
                  )
                ),
              ),
            ]
          ),
          
          SizedBox( height : screenHeight * .02),
          PocketPalFormField(
            formOnSaved: (value) => text(value),
            formHintText: bottomSheetHintText,
            formIsObsecure: wAuth.getIsObsecure,
            formOnChange: (value){
              myFormOnChange(
                value,
                rAuth
              );
            },
            formSuffixIcon: IconButton(
              icon : Icon(
                (wAuth.getIsObsecure) ? 
                  FeatherIcons.eye : 
                  FeatherIcons.eyeOff
              ),
              onPressed: rAuth.changeObsecure,
            ),
          ),

          SizedBox( height : screenHeight * .02),
          passwordValidator(
            passwordValidatorText: "Use upper and lower case character",
            passwordValidatorChecker: wAuth.getContainsUpperLower,
            passwordValidatorColor: (wAuth.getContainsUpperLower) ? 
              Colors.green : Colors.red

          ), 
          
          SizedBox( height : screenHeight * .02),
          passwordValidator(
            passwordValidatorText:  "Use at least 8 characters",
            passwordValidatorChecker: wAuth.getContainsCharacter,
            passwordValidatorColor: (wAuth.getContainsCharacter) ? 
              Colors.green : Colors.red

          ),
          
          
          SizedBox( height : screenHeight * .02),
          passwordValidator(
            passwordValidatorText: "Use 1 or more numbers ",
            passwordValidatorChecker: wAuth.getContainsNumerics,
            passwordValidatorColor: (wAuth.getContainsNumerics) ? 
              Colors.green : Colors.red

          ),
          
          SizedBox( height : screenHeight * .02),
          passwordValidator(
            passwordValidatorText: "Use 1 or more special Character",
            passwordValidatorChecker: wAuth.getContainsSymbols,
            passwordValidatorColor: (wAuth.getContainsSymbols) ? 
              Colors.green : Colors.red

          ),

          SizedBox( height : screenHeight * .04),
        ]
      ),
    );
  }

  void myFormOnChange(String value, AuthProvider rAuth) {
    RegExp containsCharacters = RegExp(r'^.{8,}$');
    RegExp containsUpper = RegExp(r"(?=.*?[A-Z])");
    RegExp containsLower = RegExp(r"(?=.*?[a-z])");
    RegExp containsNumerics = RegExp(r"(?=.*?[0-9])");
    RegExp containsSymbols = RegExp(r"(?=.*?[!@#\$&*~._,<>+-])");

    rAuth.setContainsCharacter(
      (containsCharacters.hasMatch(value)) ? true : false
    );
    rAuth.setContainsUpperLower(
      (
        containsLower.hasMatch(value) &&
        containsUpper.hasMatch(value) 
      ) ? true : false
    );
    rAuth.setContainsNumerics(
      (containsNumerics.hasMatch(value)) ? true : false
    );
    rAuth.setContainsSymbol(
      (containsSymbols.hasMatch(value)) ? true : false
    );
  }
}

Row passwordValidator({
  Color ? passwordValidatorColor,
  bool passwordValidatorChecker = false,
  String passwordValidatorText = ""
}) => Row(
  crossAxisAlignment: CrossAxisAlignment.center,
  children : [
    Icon(
      (!passwordValidatorChecker) ?
        FeatherIcons.xCircle : 
        FeatherIcons.checkCircle,

      color : passwordValidatorColor
    ),
    
    const SizedBox( width : 10 ),
    Text(
      passwordValidatorText,
      style : GoogleFonts.poppins(
        fontSize: 16
      )
    )
  ]
);