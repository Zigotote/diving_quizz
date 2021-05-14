import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class OrangeShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Orange;

  @override
  Color get primaryColor => Colors.orange.shade400;

  @override
  Color get deepColor => Colors.brown;

  @override
  Color get brightColor => Colors.orange.shade100;
}

class LightOrangeTheme extends AbstractLightTheme {
  @override
  AbstractShadeColors get shadeColors => OrangeShadeColors();
}

class DarkOrangeTheme extends AbstractDarkTheme {
  @override
  AbstractShadeColors get shadeColors => OrangeShadeColors();

  @override
  Color get switchThumbColor => Colors.brown.shade400;

  @override
  Color get switchTrackColor => Colors.brown.shade100;
}
