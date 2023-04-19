import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarView extends StatelessWidget {
  const CalendarView({super.key});

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar : AppBar(
        leading: GestureDetector(
          onTap: () {
          ZoomDrawer.of(context)!.toggle();
        },
          child: const Icon(FeatherIcons.arrowLeft)
        ),
        title: Text(
            "Calendar",
            style: GoogleFonts.poppins(
              fontSize : 18.sp,
              color: ColorPalette.black,
            ),
          ),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 14.w,
          vertical: 20.h),
        child: Container(
          height: screenHeight / 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorPalette.murky.shade100,
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SfCalendar(
              todayTextStyle: GoogleFonts.poppins(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500
              ),
              headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.center,
                textStyle: GoogleFonts.poppins(
                  color: ColorPalette.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                )
              ),
              
              showNavigationArrow: true,
              monthViewSettings: MonthViewSettings(
                monthCellStyle: MonthCellStyle(
                  backgroundColor: ColorPalette.white,
                  trailingDatesBackgroundColor: ColorPalette.lightGrey,
                  leadingDatesBackgroundColor:  ColorPalette.lightGrey,
                  todayBackgroundColor: ColorPalette.rustic.shade100,
                  textStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: ColorPalette.black
                  ),
                  trailingDatesTextStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: ColorPalette.black
                  ),
                  leadingDatesTextStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    color: ColorPalette.black
                  ),
                ),
                
              ),

            ),
          ),
        ),
      ),
    );
  }
}