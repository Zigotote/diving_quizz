import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/material.dart';

class LightGreenTheme extends MyTheme {
  LightGreenTheme() {
    this.themeName = ColorThemes.Green;
  }

  @override
  ThemeData get themeData => ThemeData.light().copyWith(
        primaryColor: Colors.green.shade800,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.green.shade800),
          ),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.lightGreen.shade900;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => Colors.lightGreen.shade50;

  @override
  List<Color> get menuColors =>
      [Colors.lightGreen.shade200, Colors.greenAccent.shade100];
}

class DarkGreenTheme extends MyTheme {
  DarkGreenTheme() {
    this.themeName = ColorThemes.Green;
  }

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.greenAccent.shade700),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.green.shade400),
          trackColor: MaterialStateProperty.all<Color>(Colors.green.shade100),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.greenAccent.shade100;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => Colors.green.shade800;

  @override
  List<Color> get menuColors => [Colors.green.shade800, Colors.teal.shade700];
}
