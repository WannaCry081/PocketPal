import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/calculator/widgets/budget_values.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';

class MyBudgetTiles extends StatelessWidget {
  final String needs;
  final String wants;
  final String savings;
  final double fontSize;

  const MyBudgetTiles({
    required this.needs,
    required this.wants,
    required this.savings,
    required this.fontSize,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 140, 
          width: 130, 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPalette.crimsonRed.shade400
          ),
          child: MyBudgetValues(
            name: "Needs",
            value: needs,
            fontSize: fontSize,
          ),
        ),
        SizedBox( height: 10.h),
        Container(
          height: 140, 
          width: 130, 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPalette.midnightBlue.shade400
          ),
          child: MyBudgetValues(
            name: "Wants",
            value: wants,
            fontSize: fontSize,
          ),
        ),
        SizedBox( height: 10.h),
        Container(
          height: 140, 
          width: 130,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorPalette.salmonPink.shade400
          ),
          child: MyBudgetValues(
            name: "Savings",
            value: savings,
            fontSize: fontSize,
          ),
        ),
      ],
    );
  }
}