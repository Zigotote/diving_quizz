import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../theme/theme_preferences.dart';
import '../widgets/back_button.dart';
import '../widgets/bot_dialog.dart';
import '../widgets/user_dialog.dart';

class MySettings extends StatefulWidget {
  @override
  _MySettingsState createState() => _MySettingsState();
}

class _MySettingsState extends State<MySettings> {
  /// The left position for the box which indicates which color theme is selected
  double _leftPositionColorSelector;

  /// Changes the leftPositionColorSelector.
  /// Depends on the selected theme color and the screen width
  void _adaptSelectedColorBoxPosition(
      double itemWidth, ThemeProvider themeProvider, double screenWidth) {
    double marginRatio = 0.035;
    if (screenWidth < 350) {
      marginRatio = 0.06;
    } else if (screenWidth < 400) {
      marginRatio = 0.045;
    }
    _leftPositionColorSelector = screenWidth * 0.01 +
        (itemWidth + (screenWidth * marginRatio)) *
            ColorThemes.values.indexOf(themeProvider.theme.themeName);
  }

  /// Builds the color theme selector row which contains :
  /// - A row with a textButton by available theme color
  /// - An animated rounded container which changes its position depending on the color selected
  Widget _buildColorSelector(double screenWidth, double screenHeight,
      double itemWidth, double itemHeight, ThemeProvider themeProvider) {
    return FittedBox(
      child: Stack(children: [
        Row(
          children: ColorThemes.values.map((color) {
            final Color primaryColor =
                color.getTheme(false).themeData.primaryColor;
            Widget circle = CircleAvatar(backgroundColor: primaryColor);
            return TextButton(
              onPressed: () {
                themeProvider.theme = color.getTheme(themeProvider.isDarkTheme);
                setState(() {
                  _adaptSelectedColorBoxPosition(
                      itemWidth, themeProvider, screenWidth);
                });
              },
              child: Container(
                width: itemWidth,
                height: itemHeight,
                child: Stack(
                  children: [
                    Positioned(
                      top: itemHeight * 0.05,
                      left: itemHeight * 0.08,
                      width: itemHeight * 0.12,
                      child: circle,
                    ),
                    Positioned(
                      top: screenHeight > 700
                          ? itemHeight * 0.2
                          : itemHeight * 0.15,
                      left: itemWidth * 0.45,
                      width: itemHeight * 0.2,
                      child: circle,
                    ),
                    Positioned(
                      top: itemHeight * 0.48,
                      left: screenHeight > 800
                          ? -itemHeight * 0.02
                          : itemHeight * 0.04,
                      width: screenHeight > 800
                          ? itemHeight * 0.5
                          : itemHeight * 0.4,
                      height: itemHeight * 0.35,
                      child: circle,
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        AnimatedPositioned(
          top: screenHeight * 0.01,
          left: _leftPositionColorSelector,
          child: Container(
            width: itemWidth * 1.1,
            height: itemHeight,
            decoration: BoxDecoration(
              border: Border.all(
                color: themeProvider.theme.textColor,
                width: screenWidth * 0.005,
              ),
              borderRadius: BorderRadius.circular(25),
            ),
          ),
          duration: Duration(milliseconds: 600),
        ),
      ]),
    );
  }

  /// Builds the switcher for the theme brightness
  Widget _buildThemeBrightnessSelector(ThemeProvider themeProvider) {
    return FlutterToggleTab(
      labels: ["Thème sombre", "Thème clair"],
      initialIndex: themeProvider.isDarkTheme ? 0 : 1,
      selectedLabelIndex: (index) => themeProvider.isDarkTheme = index == 0,
      width: 75,
      selectedTextStyle: TextStyle(color: Colors.black),
      unSelectedTextStyle: TextStyle(color: Colors.black87),
    );
  }

  /// Builds the box where the previsualization of the choosen theme is displayed
  Widget _buildExampleBox(double screenWidth, double screenHeight,
      double paddingLeft, ThemeProvider themeProvider) {
    return Column(children: [
      Stack(
        children: [
          Divider(
            color: themeProvider.theme.textColor,
          ),
          Positioned(
            left: paddingLeft,
            child: Container(
              decoration: BoxDecoration(
                color: themeProvider.theme.themeData.backgroundColor,
              ),
              width: screenWidth * 0.2,
              child: Text(
                "Exemple",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: screenHeight * 0.02,
        ),
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
          child: Column(
            children: [
              BotDialog(
                child: Text("Bonjour, je suis le professeur X."),
              ),
              UserDialog(
                child: UserText("Démarrons le quizz !"),
              )
            ],
          ),
        ),
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final double itemWidth = screenWidth * 0.14;
    final double itemHeight = screenHeight * 0.16;
    final double paddingLeft = screenWidth * 0.03;
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      if (_leftPositionColorSelector == null) {
        _adaptSelectedColorBoxPosition(itemWidth, themeProvider, screenWidth);
      }
      return Scaffold(
        appBar: AppBar(
          leading: MyBackButton(),
          title: Text("Paramètres"),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: paddingLeft,
                top: screenHeight * 0.03,
              ),
              child: Text("Couleur du thème :"),
            ),
            Padding(
              padding: EdgeInsets.only(
                left: paddingLeft,
                top: screenHeight * 0.01,
                right: paddingLeft,
              ),
              child: _buildColorSelector(screenWidth, screenHeight, itemWidth,
                  itemHeight, themeProvider),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.06,
                left: paddingLeft * 4,
              ),
              child: _buildThemeBrightnessSelector(themeProvider),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.1,
                bottom: screenHeight * 0.02,
              ),
              child: _buildExampleBox(
                  screenWidth, screenHeight, paddingLeft, themeProvider),
            ),
          ],
        ),
      );
    });
  }
}
