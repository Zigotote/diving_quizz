import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class RedShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Red;

  @override
  Color get deepColor => Colors.red.shade800;

  @override
  Color get brightColor => Colors.red.shade100;
}

class LightRedTheme extends LightTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => RedShadeColors();

  @override
  Color get primaryColor => Colors.red.shade700;

  @override
  List<Color> get menuColors =>
      [Colors.pink.shade200, Colors.redAccent.shade100];
}

class DarkRedTheme extends DarkTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => RedShadeColors();

  @override
  List<Color> get menuColors => [Colors.red.shade700, Colors.pink.shade800];

  @override
  Color get elevatedButtonColor => Colors.redAccent.shade700;

  @override
  Color get switchThumbColor => Colors.redAccent.shade400;

  @override
  Color get switchTrackColor => Colors.redAccent.shade100;
}
