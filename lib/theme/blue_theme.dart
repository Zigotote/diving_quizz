import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class BlueShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Blue;

  @override
  Color get deepColor => Colors.blueAccent;

  @override
  Color get brightColor => Colors.lightBlue.shade50;
}

class LightBlueTheme extends AbstractLightTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => BlueShadeColors();

  @override
  Color get primaryColor => Colors.blue;

  @override
  List<Color> get menuColors =>
      [Colors.lightBlue.shade200, Colors.blueAccent.shade100];
}

class DarkBlueTheme extends AbstractDarkTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => BlueShadeColors();

  @override
  List<Color> get menuColors => [Colors.blue.shade700, Colors.indigo.shade400];

  @override
  Color get elevatedButtonColor => Colors.blueAccent.shade700;

  @override
  Color get switchThumbColor => Colors.blue.shade400;

  @override
  Color get switchTrackColor => Colors.blue.shade100;
}
