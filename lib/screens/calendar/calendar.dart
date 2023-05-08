import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/providers/envelope_provider.dart';
import 'package:pocket_pal/providers/event_provider.dart';
import 'package:pocket_pal/providers/folder_provider.dart';
import 'package:pocket_pal/screens/calendar/widgets/event_tile.dart';
import 'package:pocket_pal/utils/event_structure_util.dart';
import 'package:pocket_pal/widgets/pocket_pal_appbar.dart';
import 'package:pocket_pal/widgets/pocket_pal_formfield.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pocket_pal/screens/dashboard/widgets/dialog_box.dart';



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
  

  TextEditingController _eventController = TextEditingController(text: "");

  // final eventMap = EventProvider().getEventMap;

  late Map<DateTime, List<Event>> selectedEvents = {};
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
    super.initState();
  }

  @override
  void didChangeDependencies(){
    super.didChangeDependencies();
    Provider.of<EventProvider>(
      context, 
      listen : true
    ).fetchEvent();
    return;
  }  

  @override
  void dispose(){
    _eventController.dispose();
    super.dispose();
    return;
  }

  void _addCalendarEvent(){
    showDialog(
      context: context,
      builder: (context){
        return MyDialogBoxWidget(
          controllerName: _eventController,
          dialogBoxHintText: "Event name",
          dialogBoxTitle: "Add Event",
          dialogBoxErrorMessage: "Please enter a name for your Event",
          dialogBoxOnCancel: (){
            _eventController.clear();
            Navigator.of(context).pop();
          },
          dialogBoxOnCreate: (){
            Provider.of<EventProvider>(
              context,
              listen: false
            ).addEvent(
              Event(
                eventName: _eventController.text.trim(),
                eventDate: selectedDay
              ).toMap()
            );
            _eventController.clear();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text("Event added!"))
            );
            Navigator.of(context).pop();

            if(_eventController.text.isEmpty){
              return;
            } else {
              if(selectedEvents[selectedDay]!=null){
                selectedEvents[selectedDay]!.add(
                  Event(
                    eventDate: selectedDay,
                    eventName: _eventController.text.trim(),
                  )
                );
              } else{
                selectedEvents[selectedDay] = [
                  Event(
                    eventName: _eventController.text.trim(),
                    eventDate: selectedDay
                  )
                ];
              }
            }
          },
        );
      });
      return;
  }


  @override
  Widget build(BuildContext context) {

    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    final EventProvider eventProvider = context.watch<EventProvider>();
    final List<Event> eventItem = eventProvider.getEventList;
    final Map<DateTime, List<Event>> eventMap = eventProvider.getEventMap;
    final int eventItemLength = eventItem.length;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const PocketPalAppBar(
              pocketPalTitle: "Calendar",
            ),
        
            Container(
              padding : EdgeInsets.symmetric(
                horizontal: 10.w,
              ),
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
          
          
                eventLoader: (DateTime date) => eventMap[date] ?? [],
          
                calendarStyle: CalendarStyle(
                  markerSizeScale: 1,
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
              child: 
              _eventListView(
                eventItem: eventItem,
                eventItemLength: eventItemLength
              )
            )
      
            // Column(
            //   children: [
            //     ..._getEventfromDay(selectedDay)
            //     .map((Event event) => SizedBox(
            //       height: 70.h,
            //       child: Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: MyEventListTile(
            //     event: event,
            //     eventDay:  DateFormat('d').format(event.eventDate),
            //     eventMonth: DateFormat('MMM').format(event.eventDate),
            //     eventName: event.eventName,
            //         ),
            //       ),
            //     ))
            //     .toList(),
            //   ],
            // )
          
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorPalette.crimsonRed,
        onPressed: _addCalendarEvent,
        child: Icon(
          FeatherIcons.plus,
          color: ColorPalette.white,),
          ),
        );
      }

Widget _eventListView({
  required List<Event> eventItem,
  required int eventItemLength,
}) {
  Map<DateTime, List<String>> groupedEvents = {};

  for (int i = 0; i < eventItemLength; i++) {
    DateTime dateTime = eventItem[i].eventDate;

    if (groupedEvents.containsKey(dateTime)) {
      groupedEvents[dateTime]!.add(eventItem[i].eventName);
    } 
    else {
      groupedEvents[dateTime] = [eventItem[i].eventName];
    }

     if (dateTime == focusedDay) {
      if (groupedEvents.containsKey(DateTime.now())) {
        groupedEvents[focusedDay]!.add(eventItem[i].eventName);
      } else {
        groupedEvents[DateTime.now()] = [eventItem[i].eventName];
      }
        }
  }

  return ListView(
    children: groupedEvents.entries.map((entry) {
      DateTime dateTime = entry.key;
      List<String> eventNames = entry.value;

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 5.h),
        child: SizedBox(
          height: (eventNames.length <= 4) ? 90.h : 120.h,
          child: MyEventListTile(
            eventMonth: DateFormat('MMM').format(dateTime),
            eventDay: DateFormat('dd').format(dateTime),
            eventNames: eventNames,
            isToday: (dateTime.month == DateTime.now().month && dateTime.day == DateTime.now().day),
          ),
        ),
      );
    }).toList(),
  );
}



}