import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/material.dart';

class LightBrownTheme extends MyTheme {
  LightBrownTheme() {
    this.themeName = ColorThemes.Brown;
  }

  @override
  ThemeData get themeData => ThemeData.light().copyWith(
        primaryColor: Colors.brown,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.brown),
          ),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.brown;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => Colors.orange.shade100;

  @override
  List<Color> get menuColors => [Colors.brown.shade200, Colors.orange.shade200];
}

class DarkBrownTheme extends MyTheme {
  DarkBrownTheme() {
    this.themeName = ColorThemes.Brown;
  }

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.brown.shade700),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all<Color>(Colors.brown.shade400),
          trackColor: MaterialStateProperty.all<Color>(Colors.brown.shade100),
        ),
      );

  @override
  Color get userPrimaryColor => Colors.orangeAccent.shade100;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => Colors.brown.shade600;

  @override
  List<Color> get menuColors => [Colors.brown, Colors.orange.shade900];
}
