import "package:flutter/material.dart";


class ColorPalette {
  
  static Color ? white = Colors.white;
  static Color ? black = Colors.grey[900];
  static Color ? lightGrey = Colors.grey[300];
  static Color ? grey = Colors.grey[600];

  static MaterialColor rustic = const MaterialColor(
    0xFFD65A31, {
      50: Color(0xFFFFF3F0),
      100: Color(0xFFFFE0D9),
      200: Color(0xFFFFC1B2),
      300: Color(0xFFFFA28B),
      400: Color(0xFFFF8A6F),
      500: Color(0xFFD65A31),
      600: Color(0xFFB44B27),
      700: Color(0xFF932E1E),
      800: Color(0xFF7A2218),
      900: Color(0xFF5F1813),
    }
  );

  static MaterialColor murky = const MaterialColor(
    0xFF263238, {
      50: Color(0xFFECEFF1),
      100: Color(0xFFCFD8DC),
      200: Color(0xFFB0BEC5),
      300: Color(0xFF90A4AE),
      400: Color(0xFF78909C),
      500: Color(0xFF607D8B),
      600: Color(0xFF546E7A),
      700: Color(0xFF455A64),
      800: Color(0xFF37474F),
      900: Color(0xFF263238),
    }
  );

  static MaterialColor navy = const MaterialColor(
    0xFF222831, {
      50: Color(0xFFE9EBEE),
      100: Color(0xFFC8D0D9),
      200: Color(0xFFA5B1BF),
      300: Color(0xFF8193A5),
      400: Color(0xFF627380),
      500: Color(0xFF3E4A5A),
      600: Color(0xFF35424F),
      700: Color(0xFF2B383F),
      800: Color(0xFF222831),
      900: Color(0xFF1A2127),
    }
  );  
}