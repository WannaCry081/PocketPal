import "package:flutter/material.dart";


class AuthProvider with ChangeNotifier {

  String _name = "";
  String _email = "";
  String _password = "";
  String _confirmPassword = "";

  bool _isObsecure = true;
  bool _containsCharacter = false;
  bool _containsUpperLower = false;
  bool _containsNumerics = false; 
  bool _containsSymbols = false;

  String get getName => _name;
  String get getEmail => _email;
  String get getPassword => _password;
  String get getConfirmPassword => _confirmPassword;

  void setName(String ? value) {
    _name = value!;
    notifyListeners();
  }

  void setEmail(String ? value){
    _email = value!;
    notifyListeners();
  }

  void setPassword(String ? value){
    _password = value!;
    notifyListeners();
  }

  void setConfirmPassword(String ? value){
    _confirmPassword = value!;
    notifyListeners();
  }

  bool get getIsObsecure => _isObsecure;

  void changeObsecure(){
    _isObsecure = !_isObsecure;
    notifyListeners();
    return;
  }

  bool get getContainsCharacter => _containsCharacter;
  bool get getContainsUpperLower => _containsUpperLower;
  bool get getContainsNumerics => _containsNumerics;
  bool get getContainsSymbols => _containsSymbols;

  void reset(){
    _isObsecure = true;
    _containsCharacter = false;
    _containsUpperLower = false;
    _containsNumerics = false; 
    _containsSymbols = false;

    notifyListeners();
    return;
  }

  void passwordValidator(String value) {
    RegExp containsCharacters = RegExp(r'^.{8,}$');
    RegExp containsUpper = RegExp(r"(?=.*?[A-Z])");
    RegExp containsLower = RegExp(r"(?=.*?[a-z])");
    RegExp containsNumerics = RegExp(r"(?=.*?[0-9])");
    RegExp containsSymbols = RegExp(r"(?=.*?[!@#\$&*~._,<>+-])");

    _containsCharacter = containsCharacters.hasMatch(value) ? true : false;
    _containsUpperLower = (containsLower.hasMatch(value) &&
                            containsUpper.hasMatch(value)) 
                            ? true : false;
    _containsNumerics = containsNumerics.hasMatch(value) ? true : false;
    _containsSymbols = containsSymbols.hasMatch(value) ? true : false;
    notifyListeners();
  }
}


