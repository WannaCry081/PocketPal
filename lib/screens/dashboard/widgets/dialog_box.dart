import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class MyDialogBoxWidget extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController controllerName;
  final String dialogBoxHintText;
  final String dialogBoxTitle;
  final String dialogBoxErrorMessage;
  final void Function() dialogBoxOnCancel;
  final void Function() dialogBoxOnCreate;
  
  MyDialogBoxWidget({ 
    super.key,
    required this.dialogBoxErrorMessage,
    required this.dialogBoxHintText,
    required this.controllerName,
    required this.dialogBoxTitle,
    required this.dialogBoxOnCreate,
    required this.dialogBoxOnCancel,
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      backgroundColor: ColorPalette.white,
      title: titleText(
        dialogBoxTitle,
        titleWeight: FontWeight.w600,
        titleColor : ColorPalette.crimsonRed
      ),
      content : Form(
        key : _formKey,
        child: PocketPalFormField(
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
      ),
      actions: [
        GestureDetector(
          onTap : dialogBoxOnCancel,
          child: bodyText(
            "Cancel",
            bodyWeight : FontWeight.w500,
            bodySize : 14.sp 
          ),
        ),
        GestureDetector(
          onTap : (){
            if (_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              dialogBoxOnCreate();
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