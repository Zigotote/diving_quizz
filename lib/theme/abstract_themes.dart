import 'package:flutter/material.dart';

import 'theme_preferences.dart';

/// A class with the deeper and brighter color of the theme
abstract class AbstractShadeColors {
  /// Returns the name of the theme linked to this shades
  ColorThemes get themeName;

  /// Returns the deeper color of the theme
  Color get deepColor;

  /// Returns the brighter color of the theme
  Color get brightColor;
}

/// A personnalized theme with some custom values
abstract class AbstractTheme {
  /// Returns deeper and brighter colors of the theme
  @protected
  AbstractShadeColors get shadeColorsCouple;

  /// Returns the name of the availableTheme linked to the theme
  ColorThemes get themeName => this.shadeColorsCouple.themeName;

  /// Returns the default font color for the text
  Color get textColor => this.themeData.textTheme.bodyText1.color;

  /// Returns the light or dark theme
  ThemeData get themeData;

  /// Returns the background color of the user's dialog box
  Color get userPrimaryColor;

  /// Returns the font color of the user's dialog box
  Color get userSecondaryColor;

  /// Returns the background color of the bot's dialog box
  Color get botBackgroundColor;

  /// Returns the list of the colors to use for the menu items
  List<Color> get menuColors;
}

abstract class LightTheme extends AbstractTheme {
  /// Returns the primary color of the theme
  @protected
  Color get primaryColor;

  @override
  ThemeData get themeData => ThemeData.light().copyWith(
        primaryColor: this.primaryColor,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(this.primaryColor),
          ),
        ),
      );

  @override
  Color get userPrimaryColor => this.shadeColorsCouple.deepColor;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => this.shadeColorsCouple.brightColor;
}

abstract class DarkTheme extends AbstractTheme {
  /// Returns the color for the elevated buttons
  @protected
  Color get elevatedButtonColor;

  /// Returns the color of switch button
  @protected
  Color get switchThumbColor;

  /// Returns the color of the switch bar
  @protected
  Color get switchTrackColor;

  @override
  ThemeData get themeData => ThemeData.dark().copyWith(
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor:
                MaterialStateProperty.all<Color>(this.elevatedButtonColor),
          ),
        ),
        switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.all<Color>(this.switchThumbColor),
          trackColor: MaterialStateProperty.all<Color>(this.switchTrackColor),
        ),
      );

  @override
  Color get userPrimaryColor => this.shadeColorsCouple.brightColor;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => this.shadeColorsCouple.deepColor;
}
