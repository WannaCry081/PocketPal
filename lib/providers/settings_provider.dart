import "package:flutter/material.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:connectivity_plus/connectivity_plus.dart";

class SettingsProvider with ChangeNotifier {

  SharedPreferences ? _pref;
  ConnectivityResult ? _conn;

  SettingsProvider() {
    _initPreference();
    _initConnectivity();
  }


  Future<void> _initPreference() async{
    _pref = await SharedPreferences.getInstance();
    notifyListeners();
    return;
  }

  Future<void> _initConnectivity() async {
    _conn = await Connectivity().checkConnectivity();
    notifyListeners();
    return;
  }


  bool getBoolPreference(String key) => _pref?.getBool(key) ?? true;
  int getIntPreference(String key) => _pref?.getInt(key) ?? 0;
  String getStringPreference(String key) => _pref?.getString(key) ?? "";


  Future<void> setBoolPreference(String key, bool value) async {
    await _pref?.setBool(key, value);
    notifyListeners();
    return;
  }

  Future<void> setIntPreference(String key, int value) async {
    await _pref?.setInt(key, value);
    notifyListeners();
    return;
  }

  Future<void> setStringPreference(String key, String value) async {
    await _pref?.setString(key, value);
    notifyListeners();
    return;
  }

  
  bool getHasWifi() => _conn == ConnectivityResult.none;  
  Stream<ConnectivityResult> getConnectivityResult() => Connectivity().onConnectivityChanged;
}
