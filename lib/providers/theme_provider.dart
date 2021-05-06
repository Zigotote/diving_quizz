import 'package:diving_quizz/theme/blue_theme.dart';
import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/cupertino.dart';

/// A provider to share the color theme
class ThemeProvider with ChangeNotifier {
  /// The manager of the shared preferences
  ThemePreferences _preferences;

  /// The current color theme
  MyTheme _theme;

  /// The value is true if dark theme is selected, false otherwise
  bool _isDarkTheme;

  MyTheme get theme => _theme;

  bool get isDarkTheme => _isDarkTheme;

  /// Initialized values by default to avoid errors due to async getters
  ThemeProvider() {
    _theme = LightBlueTheme();
    _isDarkTheme = false;
    _preferences = ThemePreferences();
    _getPreferences();
  }

  /// Sets the theme to the new value and saves it in the shared preferences
  set theme(MyTheme value) {
    _theme = value;
    _preferences.setTheme(_theme);
    notifyListeners();
  }

  /// Sets the brightness to the new value and saves it in the shared preferences
  set isDarkTheme(bool value) {
    _preferences.setBrightness(value);
    _getPreferences();
  }

  /// Gets the theme and brightness from the shared preferences
  Future<void> _getPreferences() async {
    _theme = await _preferences.getTheme();
    _isDarkTheme = await _preferences.getBrightness();
    notifyListeners();
  }
}
