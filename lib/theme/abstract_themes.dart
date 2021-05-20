import 'package:flutter/material.dart';

import 'theme_preferences.dart';

/// A class with the deeper and brighter color of the theme
abstract class AbstractShadeColors {
  /// Returns the name of the theme linked to this shades
  ColorThemes get themeName;

  /// Returns the primary color for the shade theme
  Color get primaryColor;

  /// Returns the deeper color of the theme
  Color get deepColor;

  /// Returns the brighter color of the theme
  Color get brightColor;
}

/// A personnalized theme with some custom values
abstract class AbstractTheme {
  /// Returns deeper and brighter colors of the theme
  @protected
  AbstractShadeColors get shadeColors;

  ///Returns a dark or light colorscheme
  @protected
  ColorScheme get colorScheme;

  /// Returns the name of the availableTheme linked to the theme
  ColorThemes get themeName => this.shadeColors.themeName;

  /// Returns the light or dark theme
  ThemeData get themeData {
    ThemeData theme = ThemeData.from(colorScheme: this.colorScheme);
    return theme.copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: this.colorScheme.background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(
          color: this.textColor,
        ),
        textTheme: theme.textTheme
            .copyWith(
              headline6: theme.textTheme.headline6.copyWith(fontSize: 20),
            )
            .apply(fontFamily: "Nunito"),
      ),
      primaryColor: this.shadeColors.primaryColor,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
            this.shadeColors.primaryColor,
          ),
          shape: MaterialStateProperty.all(CircleBorder()),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(this.userSecondaryColor),
          foregroundColor: MaterialStateProperty.all(this.userPrimaryColor),
          elevation: MaterialStateProperty.all(10),
        ),
      ),
      textTheme: theme.textTheme
          .copyWith(bodyText2: theme.textTheme.bodyText2)
          .apply(fontFamily: "Nunito"),
    );
  }

  /// Returns the default color for the text
  Color get textColor => this.colorScheme.onSurface;

  /// Returns the background color of the user's dialog box
  Color get userPrimaryColor;

  /// Returns the font color of the user's dialog box
  Color get userSecondaryColor;

  /// Returns the background color of the bot's dialog box
  Color get botBackgroundColor;
}

abstract class AbstractLightTheme extends AbstractTheme {
  @override
  ColorScheme get colorScheme => ColorScheme.light();

  @override
  Color get userPrimaryColor => this.shadeColors.deepColor;

  @override
  Color get userSecondaryColor => Colors.white;

  @override
  Color get botBackgroundColor => this.shadeColors.brightColor;
}

abstract class AbstractDarkTheme extends AbstractTheme {
  @override
  ColorScheme get colorScheme => ColorScheme.dark();

  @override
  Color get userPrimaryColor => this.shadeColors.brightColor;

  @override
  Color get userSecondaryColor => Colors.black87;

  @override
  Color get botBackgroundColor => this.shadeColors.deepColor;
}
