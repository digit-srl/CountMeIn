import 'dart:ui';

import 'package:flutter/material.dart';

class Palette {
  static const backgroundColor = Color(0xFF141A1E);
  static const primary = Color(0xFF202934);
  static const secondary = Color(0xFF39485C);
  static const accent = Color(0xFFB3C3FE);
}

class FontSizes {
  static const double scale = 1;

  // static const double headline1 = 60 * scale;
  // static const double headline2 = 40 * scale;
  // static const double headline3 = 34 * scale;
  // static const double headline4 = 30 * scale;
  // static const double headline5 = 28 * scale;
  // static const double headline6 = 26 * scale;
  // static const double headline7 = 24 * scale;
  // static const double subtitle = 22 * scale;
  // static const double subtitle1 = 20 * scale;
  // static const double subtitle2 = 18 * scale;
  static const double bodyText1 = 16 * scale;
  static const double bodyText2 = 14 * scale;
  // static const double bodyText3 = 13 * scale;
  // static const double caption = 12 * scale;
  // static const double button = 10 * scale;
  // static const double overline = 8 * scale;
}

class Themes {
  // static
}

final theme = ThemeData();
final darkTheme = ThemeData(
  backgroundColor: Palette.backgroundColor,
  scaffoldBackgroundColor: Palette.backgroundColor,
  indicatorColor: Palette.accent,
  hintColor: Palette.accent,
  primaryColor: Colors.red,
  colorScheme: theme.colorScheme.copyWith(
    secondary: Colors.orange,
    primary: Colors.white,
  ),
  textTheme: const TextTheme(bodyText1: TextStyle(color: Colors.white)),
  textSelectionTheme: const TextSelectionThemeData(
    cursorColor: Palette.accent,
  ),
  dividerColor: Palette.accent,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      primary: Palette.accent,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
      textStyle: const TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 24,
      ),
    ),
  ),
  // buttonTheme: ButtonThemeData(
  //     buttonColor: Palette.accent,
  //     disabledColor: Colors.grey,
  //     colorScheme: theme.colorScheme.copyWith(
  //       primary: Colors.green,
  //       secondary: Colors.pinkAccent,
  //     )),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Palette.primary,
    focusColor: Palette.accent,
    alignLabelWithHint: true,
    filled: true,
    floatingLabelBehavior: FloatingLabelBehavior.always,
    floatingLabelAlignment: FloatingLabelAlignment.start,
    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    disabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.green, width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Palette.backgroundColor, width: 1),
    ),
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Palette.backgroundColor, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Palette.accent, width: 1),
    ),
  ),
  // textTheme: TextTheme(
  // ),
  listTileTheme: const ListTileThemeData(
    iconColor: Palette.accent,
    textColor: Colors.white,
    tileColor: Palette.primary,
  ),
  iconTheme: const IconThemeData(
    color: Palette.accent,
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Palette.backgroundColor,
    elevation: 0.0,
  ),
);

extension TextSyleX on TextStyle {
  TextStyle get bold => this.copyWith(fontWeight: FontWeight.bold);

  TextStyle get underline =>
      this.copyWith(decoration: TextDecoration.underline);

  TextStyle get white => this.copyWith(color: Colors.white);
}
