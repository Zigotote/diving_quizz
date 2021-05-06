import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/material.dart';

class LightPurpleTheme extends MyTheme {
  LightPurpleTheme() {
    this.themeName = ColorThemes.Purple;
  }

  @override
  ThemeData get themeData => ThemeData.light().copyWith(
        primaryColor: Colors.purple.shade700,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.purple.shade700),
          ),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.purple.shade800;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => Colors.purple.shade50;

  @override
  List<Color> get menuColors =>
      [Colors.purple.shade200, Colors.deepPurpleAccent.shade100];
}

class DarkPurpleTheme extends MyTheme {
  DarkPurpleTheme() {
    this.themeName = ColorThemes.Purple;
  }

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.purpleAccent.shade700),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.purple.shade400),
          trackColor: MaterialStateProperty.all<Color>(Colors.purple.shade100),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.purpleAccent.shade100;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => Colors.purple.shade800;

  @override
  List<Color> get menuColors =>
      [Colors.purple.shade700, Colors.deepPurple.shade400];
}
