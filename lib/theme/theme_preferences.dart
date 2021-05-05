import 'package:diving_quizz/theme/blue_theme.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A manager to save the theme preferences in the shared preferences
class ThemePreferences {
  /// The key of the saved color theme
  static const String _COLOR_THEME = "color_theme";

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
    MyTheme theme;
    if (themeValue == null) {
      theme = LightBlueTheme();
    } else {
      theme = AvailableThemes.values
          .firstWhere((element) => element.toString() == themeValue)
          .theme;
    }
    return theme;
  }
}

/// List of the available themes
enum AvailableThemes { _from, LightBlue, DarkBlue }

/// Extension to link an enum value to a MyTheme class
extension AvailableThemesExtension on AvailableThemes {
  /// Links the availableThemes values to the corresponding MyTheme classes
  static final Map<AvailableThemes, MyTheme> themes = {
    AvailableThemes.LightBlue: LightBlueTheme(),
    AvailableThemes.DarkBlue: DarkBlueTheme(),
  };

  /// Gets a theme from a value
  MyTheme get theme => themes[this];
}

abstract class MyTheme {
  /// The name of the availableTheme linked to the theme
  AvailableThemes themeName;

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
