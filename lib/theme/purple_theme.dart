import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class PurpleShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Purple;

  @override
  Color get deepColor => Colors.purple.shade800;

  @override
  Color get brightColor => Colors.purple.shade50;
}

class LightPurpleTheme extends LightTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => PurpleShadeColors();

  @override
  Color get primaryColor => Colors.purple.shade700;

  @override
  List<Color> get menuColors =>
      [Colors.purple.shade200, Colors.deepPurpleAccent.shade100];
}

class DarkPurpleTheme extends DarkTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => PurpleShadeColors();

  @override
  List<Color> get menuColors =>
      [Colors.purple.shade700, Colors.deepPurple.shade400];

  @override
  Color get elevatedButtonColor => Colors.purpleAccent.shade700;

  @override
  Color get switchThumbColor => Colors.purple.shade400;

  @override
  Color get switchTrackColor => Colors.purple.shade100;
}
