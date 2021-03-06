import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class GreenShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Green;

  @override
  Color get deepColor => Colors.lightGreen.shade900;

  @override
  Color get brightColor => Colors.lightGreen.shade50;
}

class LightGreenTheme extends AbstractLightTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => GreenShadeColors();

  @override
  Color get primaryColor => Colors.green.shade800;

  @override
  List<Color> get menuColors =>
      [Colors.lightGreen.shade200, Colors.greenAccent.shade100];
}

class DarkGreenTheme extends AbstractDarkTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => GreenShadeColors();

  @override
  List<Color> get menuColors => [Colors.green.shade800, Colors.teal.shade700];

  @override
  Color get elevatedButtonColor => Colors.greenAccent.shade700;

  @override
  Color get switchThumbColor => Colors.green.shade400;

  @override
  Color get switchTrackColor => Colors.green.shade100;
}
