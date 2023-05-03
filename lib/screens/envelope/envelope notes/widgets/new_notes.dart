import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';

class MyNewNotesDialog extends StatelessWidget {
  final GlobalKey<FormState> formKey;
    final String fieldName; 
    final TextEditingController envelopeNoteName;
    final TextEditingController envelopeNoteContent;
    final Function(String) addNotesFunction;


  const MyNewNotesDialog({
    required this.formKey,
    required this.fieldName,
    required this.envelopeNoteName,
    required this.envelopeNoteContent,
    required this.addNotesFunction,
    super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
       shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)),
          contentPadding: const EdgeInsets.all(25),
      content: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
               PocketPalFormField(
                  formHintText: "Enter Note Title",
                  formController: envelopeNoteName,
                  formValidator: (value){
                      if (value!.isEmpty) {
                        return 'Please enter something.';
                      }
                      return null;
                    },
                ),
              SizedBox(height: 15.h),
              TextFormField(
                  controller : envelopeNoteContent,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                   decoration: InputDecoration(
                  hintText: "Enter your notes here", 
                  hintStyle: GoogleFonts.poppins(
                    fontSize : 14.sp,
                    color : ColorPalette.grey
                  ),
                ),
                validator: (value){
                      if (value!.isEmpty) {
                        return 'Please enter something.';
                      }
                      return null;
                    },
              ),
              SizedBox( height : 10.h),
            ],
          ),
        ) ,
      ),
      actions: [
         MaterialButton(
            color: ColorPalette.lightGrey,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Cancel",
              style:GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              )
              ),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          MaterialButton(
            color: ColorPalette.crimsonRed,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)),
            child: Text(
              "Save",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp
              )
            ),
            onPressed: (){
               if (formKey.currentState!.validate()){
                addNotesFunction(fieldName);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Notes added!"),
                    duration: Duration(seconds: 1),));
                  Navigator.of(context).pop;
               }
            },
          ),
      ],
    );
  }
}