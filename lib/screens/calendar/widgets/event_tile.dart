import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';

class MyEventListTile  extends StatelessWidget {
  final String eventDay;
  final String eventMonth;
  final String eventTitle;

  const MyEventListTile ({
    required this.eventDay,
    required this.eventMonth,
    required this.eventTitle,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: ColorPalette.pearlWhite,
        borderRadius: BorderRadius.circular(12)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 5.w,
            decoration: BoxDecoration(
              color: ColorPalette.crimsonRed,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12)
              )
            ),
          ),
          SizedBox(
            width: 30.w,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  titleText(
                    eventDay,
                    titleWeight: FontWeight.w500,
                    titleAlignment: TextAlign.center,
                    titleSize: 22.sp,
                    titleHeight: 1 
                  ),
                  bodyText(
                    eventMonth,
                    bodyAlignment: TextAlign.center,
                    bodySize: 14.sp,
                  ),
                ],
              ),
            ],
          ),
          VerticalDivider(
            color: ColorPalette.grey,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            width: 60.w,
          ),
          titleText(
            eventTitle,
            titleColor: ColorPalette.black,
            titleSize: 16.sp,
            titleWeight: FontWeight.w400
          )

        ],
      ),
    );
  }
}