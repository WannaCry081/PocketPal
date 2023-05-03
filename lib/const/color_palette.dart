import "package:flutter/material.dart";


class ColorPalette {
  
  static Color ? white = Colors.white;
  static Color ? black = Colors.grey[900];
  static Color ? lightGrey = Colors.grey[200];
  static Color ? grey = Colors.grey[500];


  // =================== Light Mode Colors ===================
  static MaterialColor crimsonRed = const MaterialColor(0xFFCD3F3E, {
    50: Color(0xFFFFEBEE),
    100: Color(0xFFFFCDD2),
    200: Color(0xFFEF9A9A),
    300: Color(0xFFE57373),
    400: Color(0xFFEF5350),
    500: Color(0xFFCD3F3E),
    600: Color(0xFFE53935),
    700: Color(0xFFD32F2F),
    800: Color(0xFFC62828),
    900: Color(0xFFB71C1C),
  });


  static MaterialColor salmonPink = const MaterialColor(0xFFFF9C91, {
    50: Color(0xFFFFF0F0),
    100: Color(0xFFFFD1CC),
    200: Color(0xFFFFA499),
    300: Color(0xFFFF7A66),
    400: Color(0xFFFF5C4F),
    500: Color(0xFFFF9C91),
    600: Color(0xFFFF3E1F),
    700: Color(0xFFFF3017),
    800: Color(0xFFFF250F),
    900: Color(0xFFFF1D09),
  });

  static MaterialColor midnightBlue = const MaterialColor(0xFF1C2938, {
    50: Color(0xFFE3E8EF),
    100: Color(0xFFBCC7D5),
    200: Color(0xFF8A9FB6),
    300: Color(0xFF586E91),
    400: Color(0xFF3E4F76),
    500: Color(0xFF1C2938),
    600: Color(0xFF182532),
    700: Color(0xFF131E2A),
    800: Color(0xFF0F1923),
    900: Color(0xFF0A1319),
  });

  static MaterialColor pearlWhite = const MaterialColor(0xFFF4F6F6, {
    50: Color(0xFFFFFFFF),
    100: Color(0xFFF7F9F9),
    200: Color(0xFFEBF0F0),
    300: Color(0xFFDFE7E7),
    400: Color(0xFFD5DFDF),
    500: Color(0xFFF4F6F6),
    600: Color(0xFFBFC9CB),
    700: Color(0xFFA4B2B4),
    800: Color(0xFF8A9B9D),
    900: Color(0xFF6A7D7E),
  });    

  // =================== Dark Mode Colors ===================
  static MaterialColor darkCrimson = const MaterialColor(0xFF8F1E1D, <int, Color>{
    50: Color(0xFFFFEBE9),
    100: Color(0xFFFFC5C1),
    200: Color(0xFFED9690),
    300: Color(0xFFDA6760),
    400: Color(0xFFC6433F),
    500: Color(0xFFB3201E),
    600: Color(0xFFA31B1A),
    700: Color(0xFF8F1E1D),
    800: Color(0xFF861B1A),
    900: Color(0xFF73191A),
  });

  static MaterialColor darkSalmon = const MaterialColor(0xFFD0645C, <int, Color>{
    50: Color(0xFFFFF1EF),
    100: Color(0xFFFFD2CD),
    200: Color(0xFFFFA69D),
    300: Color(0xFFFF7A6D),
    400: Color(0xFFFF5A49),
    500: Color(0xFFFF3A25),
    600: Color(0xFFE63320),
    700: Color(0xFFD0645C),
    800: Color(0xFFC2554E),
    900: Color(0xFFA94A44),
  });

  static MaterialColor darkMidnight = const MaterialColor(0xFF10151D, <int, Color>{
    50: Color(0xFFE3E6E9),
    100: Color(0xFFBFC6D1),
    200: Color(0xFF8B9AAD),
    300: Color(0xFF576788),
    400: Color(0xFF364D6D),
    500: Color(0xFF132E52),
    600: Color(0xFF112949),
    700: Color(0xFF10151D),
    800: Color(0xFF0D1420),
    900: Color(0xFF0A111C),
  });

  static MaterialColor darkPearl = const MaterialColor(0xFFBEBEBE, <int, Color>{
    50: Color(0xFFFFFFFF),
    100: Color(0xFFFDFDFD),
    200: Color(0xFFFAFAFA),
    300: Color(0xFFF7F7F7),
    400: Color(0xFFF3F3F3),
    500: Color(0xFFEFEFEF),
    600: Color(0xFFE8E8E8),
    700: Color(0xFFD6D6D6),
    800: Color(0xFFBEBEBE),
    900: Color(0xFF999999),
  });
}