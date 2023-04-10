import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";

class PocketPalMenuButton extends StatelessWidget {
  const PocketPalMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 14.w),
      child: IconButton(
        onPressed: () {
          ZoomDrawer.of(context)!.toggle();
        },
        icon: SvgPicture.asset("assets/icon/Menu.svg")
      ),
    );
  }
}