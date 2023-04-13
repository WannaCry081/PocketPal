import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class MyDialogBoxWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController controllerName;
  final String dialogBoxHintText;
  final String dialogBoxTitle;
  final String dialogBoxErrorMessage;
  final TextEditingController  ? envelopeAmountcontrollerName;
  final String  envelopeAmountHintText;
  final void Function() dialogBoxOnTap;
  
  MyDialogBoxWidget({ 
    super.key,
    required this.dialogBoxErrorMessage,
    required this.dialogBoxHintText,
    required this.controllerName,
    required this.dialogBoxTitle,
    required this.dialogBoxOnTap,
    this.envelopeAmountHintText ="",
    this.envelopeAmountcontrollerName,
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      title: Text(
        dialogBoxTitle,
        style : GoogleFonts.poppins(
          fontSize : 14.sp,
          fontWeight: FontWeight.w500
        )
      ),
      content : Form(
        key : _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            PocketPalFormField(
              formController: controllerName,
              formHintText: dialogBoxHintText,
              formValidator: (value){
                if (value == null || value.isEmpty){
                  return dialogBoxErrorMessage;
                } else {
                  return null;
                }
              },
            ),
            PocketPalFormField(
              formController: envelopeAmountcontrollerName,
              formHintText: envelopeAmountHintText,
              formValidator: (value){
                if(value!.isEmpty){
                  return "Please enter a starting amount.";
                }
                if(int.tryParse(value) == null){
                  return "Please enter a valid amount.";
                }
                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        GestureDetector(
          onTap : () => Navigator.of(context).pop(),
          child: Text(
            "Cancel",
            style : GoogleFonts.montserrat(
              fontWeight : FontWeight.w500
            )
          ),
        ),
        GestureDetector(
          onTap : (){
            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              dialogBoxOnTap();
            }
          },
          child: Text(
            "Create", 
            style : GoogleFonts.montserrat(
              color : ColorPalette.rustic,
              fontWeight : FontWeight.w500
            )
          ),
        )
      ],
    );
  }
}