import "package:intl/intl.dart";

import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";

class MyListTileWidget extends StatelessWidget {

  final String listTileName;
  final String listTileCode;
  final DateTime listTileDate;

  final void Function() listTileWallNavigation;
  final void Function() listTileWallOnDelete;

  const MyListTileWidget({ 
    Key ? key,
    required this.listTileName,
    required this.listTileCode,
    required this.listTileWallNavigation, 
    required this.listTileWallOnDelete,
    required this.listTileDate,
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    final DateFormat dateFormatter = DateFormat('MMM d');
    final DateTime itemDate = listTileDate;
    final String date = dateFormatter.format(itemDate).toString();

    return GestureDetector(
      onTap : listTileWallNavigation,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(), 
          children: [
            SlidableAction(
              onPressed : (context) => listTileWallOnDelete,
              icon : FeatherIcons.trash2, 
            )
          ]
        ),
        child: Container(
          height : 60.h,
          margin :  EdgeInsets.only(
            right: 18.w,
            left: 18.w,
            bottom : 10.h,
          ),
      
          decoration : BoxDecoration(
            color : ColorPalette.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow : [
              BoxShadow(
                color : ColorPalette.black!.withOpacity(.2),
                blurRadius: 4,
                offset: const Offset(0, 3)
              )
            ]
          ),
      
          child : Row(
            children : [
              SizedBox(
                width : 30.w,
                child : Center(
                  child: Container(
                    width : 6.w,
                    margin: EdgeInsets.symmetric(
                      vertical: 10.h
                    ),
                    decoration: BoxDecoration(
                      color : ColorPalette.crimsonRed,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    
                  ),
                )
              ),

              Expanded(
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children : [
                    titleText(
                      listTileName,
                      titleSize: 14.sp,
                      titleWeight : FontWeight.w600
                    ),
                    bodyText(
                      listTileCode, 
                      bodySize : 12.sp,
                      bodyColor: ColorPalette.grey
                    )
                  ]
                )
              ),

              bodyText(
                date,
                bodySize : 10.sp,
                bodyColor : ColorPalette.grey,
              ),

              SizedBox(width : 20.w)
              
            ]
          )
        ),
      ),
    );
  }
}