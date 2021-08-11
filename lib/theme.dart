import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData appThemeData = ThemeData(
  visualDensity: VisualDensity.comfortable,
  primaryColorBrightness: Brightness.light,
  primarySwatch: Colors.blue,
  primaryColor: Colors.blue,
  scaffoldBackgroundColor: Colors.white,
  dividerColor: Colors.grey,
  splashColor: const Color.fromARGB(242, 242, 242, 244),
  highlightColor: const Color(0x002196f3),
  hintColor: const Color(0xff8f8f8f),
  textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.black,
      selectionColor: Colors.blue,
      selectionHandleColor: Colors.blue),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Colors.blue,
      elevation: Consts.elevation,
    ),
  ),
  dividerTheme: const DividerThemeData(color: Colors.black38, space: 6),
  iconTheme: const IconThemeData(
      color: Colors.black38, opacity: 1.0, size: Consts.iconSize),
  errorColor: Colors.red,
  textTheme: GoogleFonts.getTextTheme(
      "Nunito Sans",
      const TextTheme(
        headline6: TextStyle(
            fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
        overline: TextStyle(
          color: Colors.grey,
        ),
        subtitle1: TextStyle(
            color: Color(0xff212121),
            fontSize: 14,
            fontWeight: FontWeight.normal),
        subtitle2: TextStyle(
            color: Colors.black45, fontSize: 14, fontWeight: FontWeight.normal),
        caption: TextStyle(
          color: Color(0xff212121),
        ),
      )),
);

/// values, which are shared across project for uniformity
class Consts {
  static const EdgeInsets allRoundBorders = EdgeInsets.all(16);
  static const EdgeInsets itemsInCardBorders = EdgeInsets.all(8);
  static const EdgeInsets listBorders =
      EdgeInsets.symmetric(vertical: 0, horizontal: 16);
  static const EdgeInsets paddingBetweenLines = EdgeInsets.fromLTRB(0, 0, 0, 2);

  static const double elevation = 10.0;
  static const double borderRadius = 10.0;
  static const double iconDefaultSize = 24.0;
  static const double iconSize = 36.0;
  static const double largeImage = 150.0;
}
