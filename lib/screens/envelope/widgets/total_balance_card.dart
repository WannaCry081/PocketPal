import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/screens/envelope/widgets/glassbox_widget.dart';

class TotalBalanceCard extends StatelessWidget {

  final double width;
  final String balance;
  final String income;
  final String expense;

  const TotalBalanceCard({
    super.key,
    required this.width,
    required this.balance,
    required this.income,
    required this.expense,
    });

  @override
  Widget build(BuildContext context) {
    return Glassbox(
      width: width ,
      height: 260,
      borderRadius: 20,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            titleText(
              "Total Balance",
              titleWeight: FontWeight.w500,
              titleColor: ColorPalette.white,
              titleSize: 18.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                "assets/icon/peso_sign.svg",
                height: 30,
                color: ColorPalette.white,
                ),
                titleText(
                  balance,
                  titleWeight: FontWeight.w700,
                  titleColor: ColorPalette.white,
                  titleSize: 44.sp,
                  titleHeight: 1.3,
                ),
              ],
            ),
            const Divider(
              indent: 15,
              endIndent: 15,
              height: 35,
            ),
            SizedBox(
              height: 60.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  incomeExpense( expense, "Expense",  FeatherIcons.arrowUp),
                  const VerticalDivider(),
                  incomeExpense( income, "Income",  FeatherIcons.arrowDown)
                ],
              ),
            )
          ],
        ),
      )
    );
  }

  Widget incomeExpense(amount, name, icon,) => 
    Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Glassbox(
              height: 30, 
              width: 30, 
              borderRadius: 20, 
              child: Center(
                child: Icon(
                    icon,
                    color: (icon == FeatherIcons.arrowUp) ? 
                    Colors.red : Colors.green
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 5.w),
              child: titleText(
                name,
                titleColor: (icon == FeatherIcons.arrowUp) ? 
                Colors.red.shade400 : Colors.green.shade500,
                titleWeight: FontWeight.w500,
                titleSize: 16.sp
              ),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
            "assets/icon/peso_sign.svg",
            height: 20,
            color: ColorPalette.white,
            ),
            titleText(
              amount,
              titleWeight: FontWeight.w600,
              titleColor: ColorPalette.white,
              titleSize: 24.sp,
              titleHeight: 1.5,
            ),
          ],
        ),
    
      ],
    );
}