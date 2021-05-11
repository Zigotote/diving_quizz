import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class RedShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Red;

  @override
  Color get primaryColor => Colors.red.shade400;

  @override
  Color get deepColor => Colors.red.shade800;

  @override
  Color get brightColor => Colors.red.shade100;
}

class LightRedTheme extends AbstractLightTheme {
  @override
  AbstractShadeColors get shadeColors => RedShadeColors();
}

class DarkRedTheme extends AbstractDarkTheme {
  @override
  AbstractShadeColors get shadeColors => RedShadeColors();

  @override
  Color get elevatedButtonColor => Colors.redAccent.shade700;

  @override
  Color get switchThumbColor => Colors.redAccent.shade400;

  @override
  Color get switchTrackColor => Colors.redAccent.shade100;
}
