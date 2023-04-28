import "package:flutter/material.dart";
import "package:google_fonts/google_fonts.dart";


// For Title Text Purposes Only
Text titleText(
  String text,{
    Color ? titleColor,
    double ? titleSize,
    FontWeight ? titleWeight,
    Color? titleBackgroundColor,
    double? titleLetterSpacing,
    double? titleWordSpacing,
    double? titleHeight

}) => Text(
  text,
  style : GoogleFonts.poppins(
    color : titleColor,
    fontSize : titleSize,
    fontWeight: titleWeight,
    backgroundColor : titleBackgroundColor,
    letterSpacing : titleLetterSpacing,
    wordSpacing : titleWordSpacing,
    height : titleHeight,
  )
);


// For Body Text Purposes Only 
Text bodyText(
  String text,{
    Color ? bodyColor,
    double ? bodySize,
    FontWeight ? bodyWeight,
    Color? bodyBackgroundColor,
    double? bodyLetterSpacing,
    double? bodyWordSpacing,
    double? bodyHeight

}) => Text(
  text,
  style : GoogleFonts.lato(
    color : bodyColor,
    fontSize : bodySize,
    fontWeight: bodyWeight,
    backgroundColor : bodyBackgroundColor,
    letterSpacing : bodyLetterSpacing,
    wordSpacing : bodyWordSpacing,
    height : bodyHeight,
  )
);
