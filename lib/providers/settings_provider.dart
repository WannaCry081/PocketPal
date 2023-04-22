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

  bool get getIsLight => _pref?.getBool("isLight") ?? true;
  bool get getIsFirstInstall => _pref?.getBool("isFirstInstall") ?? true;
  bool get getShowOnboard => _pref?.getBool("showOnboard") ?? true;

  Future<void> setIsFirstInstall(bool value) async {
    await _pref?.setBool("isFirstInstall", value);
    notifyListeners();
    return;
  }

  Future<void> setIsLight(bool value) async {
    await _pref?.setBool("isLight", value);
    notifyListeners();
    return;
  }

  Future<void> setShowOnboard(bool value) async { 
    await _pref?.setBool("showOnboard", value);
    notifyListeners();
    return;
  }
}
