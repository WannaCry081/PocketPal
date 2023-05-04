import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

import "package:pocket_pal/const/color_palette.dart";
import "package:pocket_pal/const/font_style.dart";


class MyLogoutButtonWidget extends StatelessWidget {

  const MyLogoutButtonWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        children: [
          Icon(FeatherIcons.logOut,
            color: ColorPalette.crimsonRed,
            size: 20.w
          ),

          SizedBox( width: 10.w),

          bodyText(
            "Logout", 
            bodyColor : ColorPalette.crimsonRed,
            bodyWeight : FontWeight.w600,
            bodySize : 16.sp 
          ),
        ],
      ),
    );
  }
}
