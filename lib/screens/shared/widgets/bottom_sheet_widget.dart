import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";
import "package:pocket_pal/widgets/pocket_pal_formfield.dart";

class MyBottomSheetWidget extends StatefulWidget{

  final GlobalKey<FormState> formKey;
  final TextEditingController nameController;
  final TextEditingController codeController;

  final void Function() bottomSheetOnCancel;
  final void Function() bottomSheetOnCreate;
  final void Function() bottomSheetOnJoin;

  const MyBottomSheetWidget({
    Key ? key,
    required this.formKey,
    required this.nameController,
    required this.codeController,

    required this.bottomSheetOnCancel,
    required this.bottomSheetOnCreate,
    required this.bottomSheetOnJoin,
    
  }) : super(key : key);

  @override
  State<MyBottomSheetWidget> createState() => _MyBottomSheetWidgetState();
}

class _MyBottomSheetWidgetState extends State<MyBottomSheetWidget> {

  bool _buttonState = true;

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Padding(
        padding : EdgeInsets.only(
          top : 4.h,
          right : 10.w,
          left : 10.w,
          bottom : MediaQuery.of(context).viewInsets.bottom
        ),
        child : Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 20.h
          ),
    
          child : Form(
            key : widget.formKey, 
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children : [
                titleText(
                  "Shared Wall".toUpperCase(),
                  titleColor: ColorPalette.black,
                  titleAlignment: TextAlign.center,
                  titleSize: 18.sp,
                  titleWeight: FontWeight.w500
                ),
            
                SizedBox( height: 14.h),
                _customSwitchButton(context),
                  
                SizedBox( height: 8.h),
                SizedBox(
                  height : 50.h,
                  child: PocketPalFormField(
                    formHintText: "Untitled Wall Name ${(_buttonState) ? '' : '(Optional)' }",
                    formController: widget.nameController,
                    formValidator: (value){
                      if ((value == null || value.isEmpty) && _buttonState){
                        return "Please enter a Wall Name";
                      } else {
                        return null;
                      }
                    },
                  ),
                ),
            
                PocketPalFormField(
                  formHintText: "Unique Code",
                  formController: widget.codeController,
                  formSuffixIcon: (_buttonState) ? TextButton(
                    onPressed: _dialogBoxGenerateUUID,
                    child : Text(
                      "Auto-ID",
                      style : GoogleFonts.teko(
                        fontSize: 18.sp
                      )
                    )
                  ) : null,
                  formValidator: (value){
                    if (value == null || value.isEmpty){
                      return "Please enter a Unique Code";
                    } else if (value.length < 4){
                      return "Code must be at least 4 characters long";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height : 18.h),

                _customBottomBar(context)
                
              ]
            ),
          )
        )
      ),
    );
  }

  Widget _customSwitchButton(BuildContext context){
    final double switchWidth = (MediaQuery.of(context).size.width/2) - 26.w;
    return Container(
      height : 50.h,
      decoration : BoxDecoration(
        color : ColorPalette.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child : Stack(
        alignment : Alignment.center,
        children : [
          AnimatedPositioned(
            left : (_buttonState) ? 5.w : (switchWidth-5.w), 
            duration: const Duration(milliseconds: 400),
            curve: Curves.fastLinearToSlowEaseIn,
            child : Container(
              height : 42.h, 
              width : switchWidth,
              decoration: BoxDecoration(
                color : ColorPalette.crimsonRed, 
                borderRadius: BorderRadius.circular(14)
              ),
            )
          ),

          Row(
            children : [
              Expanded(
                child: GestureDetector(
                  onTap :() => _updateButtonState(true),
                  child: Center(
                    child: titleText(
                      "Create",
                      titleSize : 14.sp,
                      titleColor: (_buttonState) ? 
                        ColorPalette.white: 
                        ColorPalette.grey,
                    ),
                  ),
                ),
              ),

              Expanded(
                child: GestureDetector(
                  onTap: () => _updateButtonState(false),
                  child: Center(
                    child: titleText(
                      "Collaborate",
                      titleSize : 14.sp,
                       titleColor: (_buttonState) ? 
                        ColorPalette.grey: 
                        ColorPalette.white,
                    ),
                  ),
                ),
              )
            ]
          ),

        ]
      )
    );
  }

  Widget _customBottomBar(BuildContext context){
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children : [
        GestureDetector(
          onTap : widget.bottomSheetOnCancel, 
          child : bodyText(
            "Cancel",
            bodySize : 14.sp,
          )
        ),
        SizedBox( width: 14.w,),
        GestureDetector(
          onTap : (_buttonState) ? 
            widget.bottomSheetOnCreate :
            widget.bottomSheetOnJoin,
          child : bodyText(
            (_buttonState) ? "Create" : "Join",
            bodyColor: ColorPalette.crimsonRed,
            bodySize : 14.sp,
          )
        ),
      ]
    );
  }

  void _dialogBoxGenerateUUID(){
    return;
  }

   void _updateButtonState(bool value){
    setState((){
      _buttonState = value;
    });
    widget.nameController.clear();
    widget.codeController.clear();
    return;
  }
}

