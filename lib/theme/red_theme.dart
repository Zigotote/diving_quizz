import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/material.dart';

class LightRedTheme extends MyTheme {
  LightRedTheme() {
    this.themeName = ColorThemes.Red;
  }

  @override
  ThemeData get themeData => ThemeData.light().copyWith(
        primaryColor: Colors.red.shade700,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.red.shade700),
          ),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.red.shade800;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => Colors.red.shade100;

  @override
  List<Color> get menuColors =>
      [Colors.pink.shade200, Colors.redAccent.shade100];
}

class DarkRedTheme extends MyTheme {
  DarkRedTheme() {
    this.themeName = ColorThemes.Red;
  }

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.redAccent.shade700),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all(Colors.red.shade400),
          trackColor: MaterialStateProperty.all(Colors.red.shade100),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.red.shade100;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => Colors.red.shade800;

  @override
  List<Color> get menuColors => [Colors.red.shade700, Colors.pink.shade800];
}
