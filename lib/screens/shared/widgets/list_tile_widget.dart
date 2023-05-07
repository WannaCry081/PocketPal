import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_slidable/flutter_slidable.dart";
import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";

class MyListTileWidget extends StatelessWidget {

  final String listTileName;
  final void Function() listTileWallNavigation;

  const MyListTileWidget({ 
    Key ? key,
    required this.listTileName,
    required this.listTileWallNavigation
  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap : listTileWallNavigation,
      child: Slidable(
        endActionPane: ActionPane(
          motion: const ScrollMotion(), 
          children: [
            SlidableAction(
              onPressed : (context){},
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
                child : titleText(
                  listTileName,
                  titleSize: 14.sp,
                  titleWeight : FontWeight.w600
                )
              )
            ]
          )
        ),
      ),
    );
  }
}