import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


class PocketPalAppBar extends StatelessWidget {

  final String pocketPalTitle;
  final bool pocketPalSearchButton;
  final void Function() ? pocketPalSearchFunction;
  
  const PocketPalAppBar({ 
    Key ? key,
    this.pocketPalTitle = "",
    this.pocketPalSearchButton = false,
    this.pocketPalSearchFunction

  }) : super(key : key);

  @override
  Widget build(BuildContext context){
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 14.w,
        vertical: 6.h
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children : [
          IconButton(
            onPressed: () {
              ZoomDrawer.of(context)!.toggle();
            },
            icon: SvgPicture.asset("assets/icon/Menu.svg")
          ),
          
          SizedBox( width : 10.w),
          
          titleText(
            pocketPalTitle,
            titleSize : 14.h,
            titleWeight : FontWeight.w600
          ),

          const Spacer(),

          (pocketPalSearchButton) ?
            GestureDetector(
              onTap : pocketPalSearchFunction,
              child : CircleAvatar(
                radius: 20.r,
                backgroundColor: ColorPalette.lightGrey,
                child: Icon(
                  FeatherIcons.search,
                  color : ColorPalette.black
                ),
              )
            ) : Container(),

          
        ]
      ),
    );
  }
}