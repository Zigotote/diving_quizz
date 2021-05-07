import 'package:flutter/material.dart';

import 'abstract_themes.dart';
import 'theme_preferences.dart';

class BrownShadeColors extends AbstractShadeColors {
  @override
  ColorThemes get themeName => ColorThemes.Brown;

  @override
  Color get deepColor => Colors.brown;

  @override
  Color get brightColor => Colors.orange.shade100;
}

class LightBrownTheme extends LightTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => BrownShadeColors();

  @override
  Color get primaryColor => Colors.brown;

  @override
  List<Color> get menuColors => [Colors.brown.shade200, Colors.orange.shade200];
}

class DarkBrownTheme extends DarkTheme {
  @override
  AbstractShadeColors get shadeColorsCouple => BrownShadeColors();

  @override
  List<Color> get menuColors => [Colors.brown, Colors.orange.shade900];

  @override
  Color get elevatedButtonColor => Colors.brown.shade700;

  @override
  Color get switchThumbColor => Colors.brown.shade400;

  @override
  Color get switchTrackColor => Colors.brown.shade100;
}
