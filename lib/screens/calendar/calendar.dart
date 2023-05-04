import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/screens/calendar/widgets/event_tile.dart';
import 'package:pocket_pal/utils/event_structure_util.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';
import 'package:pocket_pal/widgets/pocket_pal_menu_button.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';



class CalendarView extends StatefulWidget {
  const CalendarView({super.key});

  @override
  State<CalendarView> createState() => _CalendarViewState();
}

class _CalendarViewState extends State<CalendarView> {
  DateTime today = DateTime.now();
  DateTime selectedDay = DateTime.now();
  DateTime focusedDay = DateTime.now();
  CalendarFormat format = CalendarFormat.month;
  
  late Map<DateTime, List<Event>> selectedEvents;

  TextEditingController _eventController = TextEditingController();

  List<Event>  _getEventfromDay(DateTime date){
    return selectedEvents[date] ?? [];
  }

  

  void _onDaySelected(DateTime selectDay, DateTime focusDay){
    setState(() {
      selectedDay = selectDay;
      focusedDay = focusDay;
    });
  }

  @override
  void initState(){
    selectedEvents = {};
    _eventController = TextEditingController(text: "");
    super.initState();
  }

  @override
  void dispose(){
    _eventController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar : AppBar(
        leading: const PocketPalMenuButton(),
      ),
      body: Padding(
        padding:  EdgeInsets.symmetric(
          horizontal: 8.w,),
        child: Column(
          children: [
            Container(
              height: screenHeight * 0.45,
              child: TableCalendar(
                shouldFillViewport: true,
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                daysOfWeekHeight: 50,
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500
                  ),
                  weekendStyle: GoogleFonts.poppins(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: ColorPalette.crimsonRed
                  ),
                  dowTextFormatter: (date, locale) {
                    return DateFormat.E(locale).format(date).substring(0, 3);
                  },
                ),
                calendarFormat: format,
                focusedDay: selectedDay,
                headerStyle:  HeaderStyle(
                  formatButtonShowsNext: false,
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: GoogleFonts.poppins(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: ColorPalette.crimsonRed
                  ),
                  titleTextFormatter: (DateTime date, dynamic format) =>
                    DateFormat.MMMM().format(date)
                  
                ),
                availableGestures: AvailableGestures.all,
                onDaySelected: (DateTime selectDay, DateTime focusDay){
                  setState(() {
                    selectedDay = selectDay;
                    focusedDay = focusDay;
                  });
                },
                // selectedDayPredicate: (day) => isSameDay(day, today),
                selectedDayPredicate: (DateTime date){
                return isSameDay(selectedDay, date);
                },
                onFormatChanged: (CalendarFormat _format){
                  setState(() {
                    format = _format;
                  });
                },
          
          
                eventLoader: _getEventfromDay,
          
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.crimsonRed.shade200
                  ),
                  selectedDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: ColorPalette.crimsonRed.shade400
                  ),
                  defaultDecoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  weekendDecoration:  const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  markerSize: 10,
                ),
                
              ),
            ),

            Expanded(
              child: _buildEventList()
            )
            
            //Expanded(child: _buildEventList()),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorPalette.crimsonRed,
        onPressed: (){
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context){
              return AlertDialog(
                title: Text(
                  "Add Event",
                  style : GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    color : ColorPalette.crimsonRed
                  )
                ),
                content: PocketPalFormField(
                  formHintText: "Enter event title",
                  formController: _eventController,
                  ),
                actions: [
                  GestureDetector(
                    onTap : () => Navigator.pop(context), 
                    child : Text(
                      "Cancel",
                      style : GoogleFonts.poppins(
                        fontWeight : FontWeight.w500,
                        fontSize : 14.sp
                      )
                    )
                  ),
                  GestureDetector(
                    onTap: () {
                      if(_eventController.text.isEmpty){

                      } else {
                        if(selectedEvents[selectedDay]!=null){
                          selectedEvents[selectedDay]!.add(
                            Event(
                            title: _eventController.text,
                            date: selectedDay
                          ));
                        } else {
                          selectedEvents[selectedDay] = [
                            Event(
                              title: _eventController.text,
                              date: selectedDay
                            )
                          ];
                        }
                      } 
                       Navigator.pop(context);
                        _eventController.clear();
                        setState(() {});
                        return;
                    },
                    child: Text(
                      "Add",
                      style : GoogleFonts.poppins(
                      fontWeight : FontWeight.w500,
                      color: ColorPalette.crimsonRed,
                      fontSize : 14.sp
                    ),),
                  ),
                ],
              );
            }
          );
        },
      child: Icon(
        FeatherIcons.plus,
        color: ColorPalette.white,),
        ),
      );
    }

    Widget _buildEventList() {
      return ListView(
        children: _getEventfromDay(selectedDay)
            .map((Event event) => SizedBox(
              height: 70.h,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyEventListTile(
                  eventDay:  DateFormat('d').format(event.date),
                  eventMonth: DateFormat('MMM').format(event.date),
                  eventTitle: event.title,
                ),
              ),
            ))
            .toList(),
      ); 
    }
}