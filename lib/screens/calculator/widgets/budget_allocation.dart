import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/calculator/widgets/budget_values.dart';

class MyBudgetAllocation extends StatelessWidget {
  final String needs;
  final String wants;
  final String savings;
  final double fontSize;

  const MyBudgetAllocation({
    required this.needs,
    required this.wants,
    required this.savings,
    required this.fontSize,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MyBudgetValues(
            name: "Needs (50%)",
            value: needs,
            fontSize: fontSize,
          ),
          SizedBox(
            height: 60.h,
             child: VerticalDivider(
                color: ColorPalette.grey,
                width: 15,
               ),
           ),
          MyBudgetValues(
            name: "Wants (30%)",
            value: wants,
            fontSize: fontSize,
          ),
          SizedBox(
            height: 60.h,
             child: VerticalDivider(
                color: ColorPalette.grey,
                width: 15,
               ),
           ),
          MyBudgetValues(
            name: "Savings (20%)",
            value: savings,
             fontSize: fontSize,
          ),
        ],
      ),
    );
  }
}