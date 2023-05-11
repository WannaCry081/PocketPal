import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";


class PocketPalFormField extends StatelessWidget {

  final TextEditingController ? formController;
  final String formHintText;
  
  final int ? formMaxLines;
  final TextInputType ? formKeyboardType;

  final bool formIsObsecure;
  final bool formIsReadOnly;

  final Widget ? formSuffixIcon;
  final Widget ? formPrefixIcon;

  final String ? Function(String?) ? formValidator;
  final void Function() ? formOnTap;
  final void Function(String) ? formOnChange;
  final void Function(String?) ? formOnSaved;

  const PocketPalFormField({
    super.key,
    this.formController,
    this.formPrefixIcon,
    this.formMaxLines = 1,
    this.formKeyboardType,
    required this.formHintText, 
    this.formIsObsecure = false,
    this.formIsReadOnly = false,  
    this.formSuffixIcon,
    this.formValidator,
    this.formOnTap,
    this.formOnChange,
    this.formOnSaved
  });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      style: GoogleFonts.poppins(
        fontSize : 14.sp,
        color : ColorPalette.black
      ),
      controller : formController,
      obscureText: formIsObsecure,
      readOnly: formIsReadOnly,
      onTap: formOnTap,
      onChanged: formOnChange,
      onSaved: formOnSaved,

      keyboardType: formKeyboardType,
      maxLines : formMaxLines,

      decoration: InputDecoration(
        hintText: formHintText, 
  
        hintStyle: GoogleFonts.poppins(
          fontSize : 14.sp,
          color : ColorPalette.grey
        ),

        suffixIcon: formSuffixIcon,
        prefixIcon: formPrefixIcon
        
      ),

      validator: formValidator,
    );
  }
}