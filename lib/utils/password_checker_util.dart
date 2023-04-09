bool containsCharacter(String value){
  RegExp checkForCharacters = RegExp(r'^.{8,}$');
  return checkForCharacters.hasMatch(value) ? true : false;
}

bool containsLowerAndUpper(String value){
  RegExp checkForUpper = RegExp(r"(?=.*?[A-Z])");
  RegExp checkForLower = RegExp(r"(?=.*?[a-z])");

  return (checkForLower.hasMatch(value) && 
          checkForUpper.hasMatch(value)) ?
            true : 
            false;
}

bool containsSymbols(String value){
  RegExp checkForSymbols = RegExp(r"(?=.*?[!@#\$&*~._,<>+-])");

  return checkForSymbols.hasMatch(value) ? true : false;
}


bool containsNumerics(String value){
  RegExp checkForNumerics = RegExp(r"(?=.*?[0-9])");

  return checkForNumerics.hasMatch(value) ? true : false;
}

bool isEmailAddress(String value){
  String pattern = r"(^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$)";
  final regExp = RegExp(pattern);

  return regExp.hasMatch(value) ? true : false;
}