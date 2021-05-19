import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class PurpleShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Purple;

  @override
  Color get primaryColor => Colors.deepPurple.shade200;

  @override
  Color get deepColor => Colors.purple.shade800;

  @override
  Color get brightColor => Colors.purple.shade50;
}

class LightPurpleTheme extends AbstractLightTheme {
  @override
  AbstractShadeColors get shadeColors => PurpleShadeColors();
}

class DarkPurpleTheme extends AbstractDarkTheme {
  @override
  AbstractShadeColors get shadeColors => PurpleShadeColors();
}
