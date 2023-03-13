import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";
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
            size: 26
            ),

          const SizedBox( width: 24),
          Text("Logout",
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: ColorPalette.white,
              fontWeight: FontWeight.w600
            ))
        ],
      ),
    );
  }
}
