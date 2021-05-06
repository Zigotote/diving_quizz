import 'package:diving_quizz/theme/blue_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A manager to save the theme preferences in the shared preferences
class ThemePreferences {
  /// The key of the saved color theme
  static const String _COLOR_THEME = "color_theme";

  /// The key of the saved brightness
  static const String _BRIGHTNESS = "brightness";

  /// Saves the theme to use in shared preferences
  Future<void> setTheme(MyTheme theme) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_COLOR_THEME, theme.themeName.toString());
  }

  /// Gets the theme to use from shared preferences.
  /// If no theme has been choosed by the user, the blue one is returned
  Future<MyTheme> getTheme() async {
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
enum ColorThemes { Blue }

/// Extension to link an enum value to a MyTheme class
extension ColorThemesExtension on ColorThemes {
  /// Returns the right MyTheme class, depending if we want a light or dark theme
  getTheme(bool isDarkTheme) {
    MyTheme theme;
    switch (this) {
      case ColorThemes.Blue:
        theme = isDarkTheme ? DarkBlueTheme() : LightBlueTheme();
        break;
    }
    return theme;
  }
}

abstract class MyTheme {
  /// The name of the availableTheme linked to the theme
  ColorThemes themeName;

  /// Returns the light or dark theme
  ThemeData get themeBrightness => ThemeData.light();

  /// Returns the background color of the user's dialog box
  Color get userPrimaryColor;

  /// Returns the font color of the user's dialog box
  Color get userSecondaryColor;

  /// Returns the background color of the bot's dialog box
  Color get botBackgroundColor;

  /// Returns the font color of the bot's dialog box
  Color get botFontColor;

  /// Returns the list of the colors to use for the menu items
  List<Color> get menuColors;
}
