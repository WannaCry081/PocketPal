import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:google_fonts/google_fonts.dart";

import "package:pocket_pal/const/color_palette.dart";


class MyLogoutButtonWidget extends StatelessWidget {

  const MyLogoutButtonWidget({ super.key });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0),
      child: Row(
        children: [
          Icon(FeatherIcons.logOut,
            color: ColorPalette.white,
            size: 20.w
          ),

          SizedBox( width: 10.w),
          Text("Logout",
            style: GoogleFonts.poppins(
              fontSize: 14.sp,
              color: ColorPalette.white,
              fontWeight: FontWeight.w600
            ))
        ],
      ),
    );
  }
}
