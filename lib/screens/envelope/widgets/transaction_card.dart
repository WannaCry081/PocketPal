import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';  
import 'package:intl/intl.dart';
import 'package:pocket_pal/const/font_style.dart';

class TransactionCard extends StatelessWidget {

  final double width;

  final String transactionName;
  final String transactionAmount;
  final String transactionType;
  final String transactionCategory;
  final Color? categoryColor;

  final String transactionUsername;
  final String dateCreated;

  final Function(BuildContext)? onPressedDelete;

  const TransactionCard({
    super.key,
    required this.transactionUsername,
    required this.dateCreated,
    required this.transactionName,
    required this.transactionAmount,
    required this.transactionType,
    required this.transactionCategory,
    required this.categoryColor,
    required this.width,
    required this.onPressedDelete,
    });

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String dateCreated = DateFormat('MMM dd').format(now);

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20)
            ),
            onPressed: onPressedDelete,
            icon:FeatherIcons.trash,
            backgroundColor: Colors.red,
            ),

        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 10.h),
        width: width - 10,
        decoration: BoxDecoration(
          color: ColorPalette.white,
        ),
        child: Column(
          children: [
          Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:[
            titleText(
              transactionName,
              titleColor: ColorPalette.crimsonRed,
              titleWeight: FontWeight.w600,
              titleSize: 16.sp,
            ),
            titleText( 
              (transactionType == "Expense" ? "-" : "+") + 
              transactionAmount,
              titleColor: transactionType == "Expense" 
                  ? Colors.red 
                  : Colors.green,
              titleWeight: FontWeight.w600,
              titleSize: 16.sp,
            ),
          ],
        ),
        SizedBox(height: 2.h,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: categoryColor ?? ColorPalette.grey,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 1.0.h,
                      horizontal: 10.w),
                    child: Text(
                      transactionCategory.toUpperCase(),
                      style: GoogleFonts.poppins(
                        color: ColorPalette.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 12.sp
                      ),),
                  ),
                ),
                SizedBox( width: 5.w),
                Text(
                  transactionUsername,
                  style: GoogleFonts.poppins(
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w500,
                    fontSize: 13.sp
                  ),),
              ],
            ),
              Text(
                dateCreated,
                style: GoogleFonts.poppins(
                  color: Colors.grey[700],
                  fontSize: 12.sp
                ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}