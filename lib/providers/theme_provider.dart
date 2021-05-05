import 'package:diving_quizz/theme/blue_theme.dart';
import 'package:diving_quizz/theme/theme_preferences.dart';
import 'package:flutter/cupertino.dart';

/// A provider to share the color theme
class ThemeProvider with ChangeNotifier {
  /// The manager of the shared preferences
  ThemePreferences _preferences;

  /// The current color theme, initialized by default to avoid errors due to async getters
  MyTheme _theme = LightBlueTheme();

  MyTheme get theme => _theme;

  ThemeProvider() {
    _preferences = ThemePreferences();
    _getTheme();
  }

  /// Sets the theme to the new value and saves it in the shared preferences
  set theme(MyTheme value) {
    _theme = value;
    _preferences.setTheme(_theme);
    notifyListeners();
  }

  /// Gets the theme from the shared preferences
  Future<void> _getTheme() async {
    _theme = await _preferences.getTheme();
    notifyListeners();
  }
}
