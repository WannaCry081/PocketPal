import "package:flutter/material.dart";
import "package:flutter_feather_icons/flutter_feather_icons.dart";

import "package:pocket_pal/screens/dashboard/dashboard.dart";
import "package:pocket_pal/screens/profile/profile.dart";
import "package:pocket_pal/screens/settings/settings.dart";

import 'package:pocket_pal/utils/menu_item_util.dart'; 

class MenuScreenProvider with ChangeNotifier {

  MenuItem _currentPage = const MenuItem(
      "Dashboard", 
      FeatherIcons.home,
      //DashboardView()
    );
  
  final List<MenuItem> _pocketPalMenuItems = const [
    MenuItem(
      "Home", 
      FeatherIcons.home,
      //DashboardView()
    ),

    MenuItem(
      "Profile", 
      FeatherIcons.user,
      //ProfileView(),
    ),

    MenuItem(
      "Settings",
      FeatherIcons.settings,
      //SettingsView()
    ),
  ];

  List <MenuItem> get getPocketPalMenuItems => _pocketPalMenuItems;

  MenuItem get getCurrentPage => _currentPage;

  set setCurrentPage(MenuItem value) {
    _currentPage = value;
    notifyListeners();
  }
}