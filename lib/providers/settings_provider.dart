import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";


class SettingsProvider with ChangeNotifier {
  SharedPreferences ? _pref;

  SettingsProvider() {
    _initPref();
  }

  Future<void> _initPref() async{
    _pref = await SharedPreferences.getInstance();
    notifyListeners();
    return;
  }

  bool get getIsDarkTheme => _pref?.getBool("isDark") ?? false;
  bool get getFirstInstall => _pref?.getBool("firstInstall") ?? true;

  set setFirstInstall(bool value) {
    _pref?.setBool("firstInstall", value);
    notifyListeners();
  }

  set setDarkTheme(bool value){
    _pref?.setBool("isDark", value);
    notifyListeners();
  }


  void setDefaultSettings() {
    _pref?.setBool("isDark", false);
    notifyListeners();
    return;
  }
}
