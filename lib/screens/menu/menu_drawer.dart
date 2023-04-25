import "package:flutter/material.dart";
import "package:flutter_zoom_drawer/flutter_zoom_drawer.dart";
import "package:pocket_pal/screens/calculator/calculator.dart";
import 'package:pocket_pal/screens/calendar/calendar.dart';
import "package:pocket_pal/screens/notifications/notifications.dart";
import "package:pocket_pal/utils/folder_structure_util.dart";
import "package:pocket_pal/utils/menu_item_util.dart";

import "package:pocket_pal/const/color_palette.dart";

import "package:pocket_pal/screens/menu/menu.dart";
import "package:pocket_pal/screens/dashboard/dashboard.dart";
import "package:pocket_pal/screens/profile/profile.dart";
import "package:pocket_pal/screens/settings/settings.dart";

class MenuDrawerView extends StatefulWidget {
  const MenuDrawerView({
    super.key});

  @override
  State<MenuDrawerView> createState() => _MenuDrawerViewState();
}

class _MenuDrawerViewState extends State<MenuDrawerView> {
  MenuItem currentItem = MenuItems.home;
  
  @override
  Widget build(BuildContext context) {

    final screenWidth = MediaQuery.of(context).size.width;

    return ZoomDrawer(
      menuBackgroundColor: ColorPalette.black!,
      borderRadius: 30,

      angle: 0.0,
      showShadow: true,

      mainScreenTapClose: true,
      menuScreenTapClose: true,

      mainScreen: getScreen(),
      menuScreen:  Builder(
          builder: (context) => MenuView(
              currentItem: currentItem,
              onSelectedItem: (item) {
                setState(() => currentItem = item);
                ZoomDrawer.of(context)!.close();
            }),
        ),

      slideWidth: screenWidth * 0.75,
      menuScreenWidth: screenWidth * 0.7,
      mainScreenScale: 0.2,
    );
  }

   Widget getScreen(){
    switch (currentItem) {
      case MenuItems.home:
        return DashboardView();
      case MenuItems.profile:
        return const ProfileView();
      case MenuItems.calendar:
        return const CalendarView();
      case MenuItems.calculator:
        return const CalculatorView();
      case MenuItems.notifications:
        return const NotificationsView();
      case MenuItems.settings:
        return const SettingsView();
      default: 
        return  DashboardView();
    }
  }
}