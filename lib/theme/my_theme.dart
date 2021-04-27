import 'package:flutter/material.dart';

extension MyTheme on ColorScheme {
  /// Returns true if light theme is activated
  bool get _isLightTheme => brightness == Brightness.light;

  /// Returns the background color of the user's dialog box
  Color get userPrimaryColor => _isLightTheme
      ? Colors.blueAccent
      : Colors.blueAccent.shade100; //TODO TO IMPROVE

  /// Returns the font color of the user's dialog box
  Color get userSecondaryColor => _isLightTheme ? Colors.white : Colors.black87;

  /// Returns the background color of the bot's dialog box
  Color get botBackgroundColor =>
      _isLightTheme ? Colors.lightBlue.shade50 : Colors.blueAccent.shade700;

  /// Returns the font color of the bot's dialog box
  Color get botFontColor => _isLightTheme ? Colors.black : Colors.white;
}
