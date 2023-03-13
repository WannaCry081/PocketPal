import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";


class SettingsProvider with ChangeNotifier {
  SharedPreferences ? pref;

  SettingsProvider() {
    _initPref();
  }

  Future<void> _initPref() async{
    pref = await SharedPreferences.getInstance();
    notifyListeners();
    return;
  }

  set setFirstInstall(bool value) {
    pref?.setBool("firstInstall", value);
    notifyListeners();
  }

  set setDarkTheme(bool value){
    pref?.setBool("isDark", value);
    notifyListeners();
  }

  bool get getIsDarkTheme => pref?.getBool("isDark") ?? false;
  bool get getFirstInstall => pref?.getBool("firstInstall") ?? true;

  void setDefaultSettings() {
    pref?.setBool("isDark", false);
    notifyListeners();
    return;
  }
}
