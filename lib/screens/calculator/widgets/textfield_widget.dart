import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';

class MyCalculatorTextFieldWidget extends StatelessWidget {
  final TextEditingController incomeController;
  final double screenWidth;
  
  const MyCalculatorTextFieldWidget({
    required this.incomeController,
    required this.screenWidth,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenWidth * 0.70,
        decoration: BoxDecoration(
        boxShadow: [
            BoxShadow(
            color: ColorPalette.black!.withOpacity(0.25),
            offset: const Offset(0,4),
            blurRadius: 4.0,
            spreadRadius: 0
          ),
        ],
      ),
      child: TextFormField(
        controller: incomeController,
        keyboardType: TextInputType.number,
        style: GoogleFonts.poppins (fontSize: 16.sp),
        decoration: InputDecoration(
          prefix: Padding(
            padding: const EdgeInsets.only(right: 5.0),
            child: SvgPicture.asset(
                "assets/icon/peso_sign.svg",
                height: 14.h,
            ),
          ),
          contentPadding: EdgeInsets.all(15),
          fillColor: ColorPalette.white,
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: ColorPalette.grey!
            ),
            borderRadius: const BorderRadius.all(
                  Radius.circular(12),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: ColorPalette.rustic.shade200
                ),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
        ),
        validator: (value){
          if(value!.isEmpty){
            return 'Please enter an amount.';
          }
          return null;
        },
      )
    );
  }
}