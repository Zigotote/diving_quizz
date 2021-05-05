import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/material.dart';

class LightBlueTheme extends MyTheme {
  LightBlueTheme() {
    this.themeName = AvailableThemes.LightBlue;
  }

  @override
  Color get userPrimaryColor => Colors.blueAccent;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => Colors.lightBlue.shade50;

  @override
  Color get botFontColor => Colors.black;

  @override
  List<Color> get menuColors => [Colors.cyan, Colors.indigo];
}

class DarkBlueTheme extends MyTheme {
  DarkBlueTheme() {
    this.themeName = AvailableThemes.DarkBlue;
  }

  @override
  Color get userPrimaryColor => Colors.blueAccent.shade100;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => Colors.blue.shade800;

  @override
  Color get botFontColor => Colors.white;

  @override
  List<Color> get menuColors =>
      [Colors.lightBlue.shade200, Colors.indigo.shade200];
}
