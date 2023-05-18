import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pocket_pal/const/color_palette.dart';
import 'package:pocket_pal/const/font_style.dart';
import 'package:pocket_pal/utils/event_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyEventListTile  extends StatelessWidget {

  final Event  event;
  final String eventMonth;
  final String eventDay;

  final bool isToday;
  final Function(BuildContext)? onPressedDelete;

  const MyEventListTile ({
    required this.event,
    required this.eventMonth,
    required this.eventDay,
    required this.onPressedDelete,
    this.isToday = false,
    super.key});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const StretchMotion(),
        children:[
          SlidableAction(
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(10),
              bottomRight: Radius.circular(10)
            ),
            onPressed: onPressedDelete,
            icon:FeatherIcons.trash,
            backgroundColor: Colors.red,
            ),
        ]
      ),
      child: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: isToday ? Color.fromARGB(255, 255, 237, 237) : ColorPalette.pearlWhite,
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 5.w,
              decoration: BoxDecoration(
                color: isToday ? ColorPalette.crimsonRed : Colors.greenAccent,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10)
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
                      //event?.eventDate != null ? DateFormat('dd').format(event!.eventDate) : '',
                      //DateFormat('dd').format(eventDate),
                      eventDay,
                      titleWeight: FontWeight.w600,
                      titleAlignment: TextAlign.center,
                      titleSize: 22.sp,
                      titleHeight: 1,
                      titleColor: isToday ? ColorPalette.crimsonRed : ColorPalette.black
                      
                    ),
                    bodyText(
                      //event?.eventDate != null ? DateFormat('MMM').format(event!.eventDate) : '',
                      eventMonth,
                      bodyAlignment: TextAlign.center,
                      bodySize: 14.sp,
                      bodyColor: isToday ? ColorPalette.salmonPink :  ColorPalette.grey
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
              event.eventName,
              titleColor: ColorPalette.black,
              titleSize: 16.sp,
              titleWeight: FontWeight.w400
            )
    
          ],
        ),
      ),
    );
  }
}