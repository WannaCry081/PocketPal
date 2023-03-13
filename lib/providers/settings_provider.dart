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

  bool get getFirstInstall => pref?.getBool("firstInstall") ?? true;

  void setDefaultSettings() {
    pref?.setBool("firstInstall", true);
    notifyListeners();
    return;
  }
}
