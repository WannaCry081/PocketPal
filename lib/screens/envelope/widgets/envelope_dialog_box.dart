import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';

class MyEnvelopeDialogBoxWidget extends StatelessWidget {
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController controllerName;
  final TextEditingController controllerAmount;
  final String dialogBoxHintText;
  final String dialogBoxTitle;
  final String dialogBoxErrorMessage;
  final String  envelopeAmountHintText;
  final void Function() dialogBoxOnTap;

  MyEnvelopeDialogBoxWidget({
    required this.dialogBoxErrorMessage,
    required this.dialogBoxHintText,
    required this.controllerName,
    required this.dialogBoxTitle,
    required this.dialogBoxOnTap,
    required this.envelopeAmountHintText,
    required this.controllerAmount,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: titleText(
        dialogBoxTitle,
        titleWeight: FontWeight.w600,
        titleColor : ColorPalette.crimsonRed
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
            Row(
              children: [
                bodyText(
                  "Php",
                  bodyWeight : FontWeight.w600,
                  bodySize : 15.sp,
                  bodyColor: ColorPalette.grey
                ),
                SizedBox( width: 5.w,),
                Expanded(
                  child: PocketPalFormField(
                    formController: controllerAmount,
                    formHintText: envelopeAmountHintText,
                    formKeyboardType: TextInputType.number,
                    formValidator: (value){
                      if(value!.isEmpty){
                        return "Please enter a starting amount.";
                      }
                      if(double.tryParse(value) == null){
                        return "Please enter a valid amount.";
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      actions: [
        GestureDetector(
          onTap : (){
            controllerName.clear();
            controllerAmount.clear();
            Navigator.of(context).pop();
          }, 
          child:  bodyText(
            "Cancel",
            bodyWeight : FontWeight.w500,
            bodySize : 14.sp 
          ),
        ),
        GestureDetector(
          onTap : (){
            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              dialogBoxOnTap();
            }
          },
          child: bodyText(
            "Create", 
            bodyColor : ColorPalette.crimsonRed,
            bodyWeight : FontWeight.w500,
            bodySize : 14.sp 
          ),
        )
      ],
    );
  }
}