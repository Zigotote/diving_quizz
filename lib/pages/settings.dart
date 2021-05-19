import 'package:flutter/material.dart';
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

  /// Builds the color theme selector row which contains :
  /// - A row with a textButton by available theme color
  /// - An animated rounded container which changes its position depending on the color selected
  Stack _buildColorSelector(double screenWidth, double screenHeight,
      double itemWidth, double itemHeight, ThemeProvider themeProvider) {
    return Stack(children: [
      AnimatedPositioned(
        left: _leftPositionColorSelector,
        top: screenHeight * 0.015,
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
      Row(
        children: ColorThemes.values.map((color) {
          final Color primaryColor =
              color.getTheme(false).themeData.primaryColor;
          Widget circle = CircleAvatar(backgroundColor: primaryColor);
          return TextButton(
            onPressed: () {
              themeProvider.theme = color.getTheme(themeProvider.isDarkTheme);
              setState(() {
                _leftPositionColorSelector = screenWidth * 0.01 +
                    (itemWidth * 1.3) * ColorThemes.values.indexOf(color);
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
                    width: itemWidth * 0.25,
                    child: circle,
                  ),
                  Positioned(
                    top: itemHeight * 0.15,
                    left: itemWidth * 0.45,
                    width: itemWidth * 0.4,
                    child: circle,
                  ),
                  Positioned(
                    top: itemHeight * 0.48,
                    left: itemWidth * 0.04,
                    width: itemWidth * 0.75,
                    child: circle,
                  )
                ],
              ),
            ),
          );
        }).toList(),
      ),
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
      String themeValue = themeProvider.isDarkTheme ? "sombre" : "clair";
      if (_leftPositionColorSelector == null) {
        _leftPositionColorSelector = screenWidth * 0.01 +
            (itemWidth * 1.3) *
                ColorThemes.values.indexOf(themeProvider.theme.themeName);
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
                top: screenHeight * 0.02,
              ),
              child: Text("Couleur du thème :"),
            ),
            Padding(
              padding: EdgeInsets.only(left: paddingLeft),
              child: _buildColorSelector(screenWidth, screenHeight, itemWidth,
                  itemHeight, themeProvider),
            ),
            Row(
              children: [
                Switch(
                  value: themeProvider.isDarkTheme,
                  onChanged: (bool value) {
                    setState(() {
                      themeProvider.isDarkTheme = value;
                    });
                  },
                ),
                Text("Thème $themeValue activé"),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 30, bottom: 5),
              child: Text(
                "Exemple :",
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: themeProvider.isDarkTheme
                        ? Colors.white
                        : themeProvider.theme.themeData.primaryColor,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
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
          ],
        ),
      );
    });
  }
}
