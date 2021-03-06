import 'package:shared_preferences/shared_preferences.dart';

import 'abstract_themes.dart';
import 'blue_theme.dart';
import 'brown_theme.dart';
import 'green_theme.dart';
import 'purple_theme.dart';
import 'red_theme.dart';

/// A manager to save the theme preferences in the shared preferences
class ThemePreferences {
  /// The key of the saved color theme
  static const String _COLOR_THEME = "color_theme";

  /// The key of the saved brightness
  static const String _BRIGHTNESS = "brightness";

  /// Saves the theme to use in shared preferences
  Future<void> setTheme(AbstractTheme theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_COLOR_THEME, theme.themeName.toString());
  }

  /// Gets the theme to use from shared preferences.
  /// If no theme has been choosed by the user, the blue one is returned
  Future<AbstractTheme> getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String themeValue = sharedPreferences.getString(_COLOR_THEME);
    ColorThemes color;
    if (themeValue == null) {
      color = ColorThemes.Blue;
    } else {
      color = ColorThemes.values
          .firstWhere((element) => element.toString() == themeValue);
    }
    return color.getTheme(await getBrightness());
  }

  /// Saves the current brightness, true if it is dark, false otherwise
  Future<void> setBrightness(bool isDark) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_BRIGHTNESS, isDark);
  }

  /// Gets the application brightness : true for dark theme, false otherwise
  Future<bool> getBrightness() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(_BRIGHTNESS) ?? false;
  }
}

/// List of the available color themes
enum ColorThemes { Blue, Red, Purple, Brown, Green }

/// Extension to link an enum value to a MyTheme class
extension ColorThemesExtension on ColorThemes {
  /// Returns the right MyTheme class, depending if we want a light or dark theme
  AbstractTheme getTheme(bool isDarkTheme) {
    AbstractTheme theme;
    switch (this) {
      case ColorThemes.Blue:
        theme = isDarkTheme ? DarkBlueTheme() : LightBlueTheme();
        break;
      case ColorThemes.Red:
        theme = isDarkTheme ? DarkRedTheme() : LightRedTheme();
        break;
      case ColorThemes.Purple:
        theme = isDarkTheme ? DarkPurpleTheme() : LightPurpleTheme();
        break;
      case ColorThemes.Brown:
        theme = isDarkTheme ? DarkBrownTheme() : LightBrownTheme();
        break;
      case ColorThemes.Green:
        theme = isDarkTheme ? DarkGreenTheme() : LightGreenTheme();
        break;
    }
    return theme;
  }
}
