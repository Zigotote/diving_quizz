import 'package:flutter/material.dart';

extension MyTheme on ColorScheme {
  /// Returns true if light theme is activated
  bool get _isLightTheme => brightness == Brightness.light;

  /// Returns the background color of the user's dialog box
  Color get userPrimaryColor =>
      _isLightTheme ? Colors.blueAccent : Colors.blueAccent.shade100;

  /// Returns the font color of the user's dialog box
  Color get userSecondaryColor => _isLightTheme ? Colors.white : Colors.black87;

  /// Returns the background color of the bot's dialog box
  Color get botBackgroundColor =>
      _isLightTheme ? Colors.lightBlue.shade50 : Colors.blue.shade800;

  /// Returns the font color of the bot's dialog box
  Color get botFontColor => _isLightTheme ? Colors.black : Colors.white;

  /// Returns the list of the colors to use for the menu items
  List<Color> get menuColors => _isLightTheme
      ? [Colors.cyan, Colors.indigo]
      : [Colors.lightBlue.shade200, Colors.indigo.shade200];
}
