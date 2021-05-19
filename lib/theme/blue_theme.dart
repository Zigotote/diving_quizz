import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class BlueShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Blue;

  @override
  Color get primaryColor => Colors.lightBlue.shade200;

  @override
  Color get deepColor => Colors.blueAccent;

  @override
  Color get brightColor => Colors.lightBlue.shade50;
}

class LightBlueTheme extends AbstractLightTheme {
  @override
  AbstractShadeColors get shadeColors => BlueShadeColors();
}

class DarkBlueTheme extends AbstractDarkTheme {
  @override
  AbstractShadeColors get shadeColors => BlueShadeColors();
}
