import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/material.dart';

class LightBlueTheme extends MyTheme {
  LightBlueTheme() {
    this.themeName = ColorThemes.Blue;
  }

  @override
  ThemeData get themeData => ThemeData.light();

  @override
  Color get userPrimaryColor => Colors.blueAccent;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => Colors.lightBlue.shade50;

  @override
  List<Color> get menuColors =>
      [Colors.lightBlue.shade200, Colors.blueAccent.shade100];
}

class DarkBlueTheme extends MyTheme {
  DarkBlueTheme() {
    this.themeName = ColorThemes.Blue;
  }

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.blueAccent.shade700),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.blue.shade400),
          trackColor: MaterialStateProperty.all<Color>(Colors.blue.shade100),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.lightBlue.shade50;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => Colors.blueAccent;

  @override
  List<Color> get menuColors => [Colors.blue.shade700, Colors.indigo.shade400];
}
