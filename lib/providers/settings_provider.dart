import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";

class SettingsProvider with ChangeNotifier {

  SharedPreferences ? _pref;

  SettingsProvider() {
    _initPackages();
  }

  Future<void> _initPackages() async{
    _pref = await SharedPreferences.getInstance();
    notifyListeners();
    return;
  }

  Future<void> setIsFirstInstall(bool value) async {
    await _pref?.setBool("isFirstInstall", value);
    notifyListeners();
    return;
  }

  Future<void> setIsLightMode(bool value) async {
    await _pref?.setBool("isLightMode", value);
    notifyListeners();
    return;
  }

  bool get getIsLightMode => _pref?.getBool("isLightMode") ?? true;
  bool get getIsFirstInstall => _pref?.getBool("isFirstInstall") ?? true;

}
