import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:table_calendar/table_calendar.dart';


class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime today = DateTime.now();
  CalendarFormat format = CalendarFormat.month;

  void _onDaySelected(DateTime day, DateTime focusedDay){
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
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
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TableCalendar(
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: today,
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false
              ),
              availableGestures: AvailableGestures.all,
              onDaySelected: _onDaySelected,
              selectedDayPredicate: (day) => isSameDay(day, today),
              onFormatChanged: (CalendarFormat _format){
                setState(() {
                  format = _format;
                });
              },
              calendarStyle: CalendarStyle(
                todayDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalette.rustic.shade200
                ),
                selectedDecoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: ColorPalette.rustic.shade400
                ),
              ),
              
            )
          ),
        ),
      ),
    );
  }
}