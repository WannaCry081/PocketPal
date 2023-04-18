import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';  
import 'package:intl/intl.dart';

class TransactionCard extends StatelessWidget {

  final double width;

  final String transactionName;
  final String transactionAmount;
  final String transactionType;


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
    required this.width,
    required this.onPressedDelete,
    });

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String dateCreated = DateFormat('MMM dd').format(now);

    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: null,
            icon:FeatherIcons.edit,
            backgroundColor: ColorPalette.murky,
            foregroundColor: ColorPalette.white,
            ),
          SlidableAction(
            onPressed: onPressedDelete,
            icon:FeatherIcons.trash,
            backgroundColor: Colors.red,
            ),

        ],
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
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
            Text(
              transactionName,
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                color: ColorPalette.rustic,
                fontWeight: FontWeight.w600
              )
            ),
            Text( 
              (transactionType == "Expense" ? "-" : "+") + 
              transactionAmount,
              style: GoogleFonts.poppins(
                color: transactionType == "Expense" 
                  ? Colors.red 
                  : Colors.green,
                fontWeight: FontWeight.w600,
                fontSize: 18.sp,
              ),
            ),
          ],
        ),
      
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              transactionUsername,
              style: GoogleFonts.poppins(
                color: ColorPalette.grey,
                fontWeight: FontWeight.w500,
                fontSize: 12.sp
              ),),
            Text(
              dateCreated,
              style: GoogleFonts.poppins(
                color: ColorPalette.grey,
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