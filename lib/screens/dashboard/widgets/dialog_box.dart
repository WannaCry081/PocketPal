import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/widgets/pocket_pal_button.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";


class MyDialogBoxWidget extends StatelessWidget {

  final TextEditingController folderName;
  final String dialogBoxTitle;
  final void Function() dialogBoxOnTap;
  
  const MyDialogBoxWidget({ 
    super.key,
    required this.folderName,
    required this.dialogBoxTitle,
    required this.dialogBoxOnTap,
  });

  @override
  Widget build(BuildContext context){
    return AlertDialog(
      title: Text(
        dialogBoxTitle,
        style : GoogleFonts.poppins(
          fontSize : 18.sp,
          fontWeight: FontWeight.w500
        )
      ),
      content : SizedBox(
        height : 120.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children :[
            PocketPalFormField(
              formController: folderName,
              formHintText: "Folder Name",
            ),
      
            PocketPalButton(
              buttonOnTap: dialogBoxOnTap, 
              buttonWidth: double.infinity, 
              buttonHeight: 50.h, 
              buttonBorderRadius: 100,
              buttonColor: ColorPalette.rustic, 
              buttonChild: Text(
                "Okay",
                style : GoogleFonts.poppins(
                  fontSize : 16.sp,
                  fontWeight : FontWeight.w500,
                  color : ColorPalette.white
                )
              )
            )
          ]
        ),
      )
    );
  }
}