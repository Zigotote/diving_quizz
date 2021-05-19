import 'package:diving_quizz/providers/theme_provider.dart';
import 'package:diving_quizz/theme/abstract_themes.dart';
import 'package:diving_quizz/widgets/my_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_circular_text/circular_text/model.dart';
import 'package:flutter_circular_text/circular_text/widget.dart';
import 'package:provider/provider.dart';

import 'reactions_quizz.dart';
import 'settings.dart';
import 'signs_quizz.dart';

class Home extends StatelessWidget {
  /// The folder where the item menu images are stored
  static const String _IMAGE_FOLDER = "assets/images/menus/";

  /// Navigates to another page
  void _navigateTo(context, StatefulWidget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  /// Builds the background with the diver picture and a circle behind it
  List<Positioned> _buildBackground(
      Color primaryColor, double screenHeight, double screenWidth) {
    final double circleSize = screenWidth * 0.9;
    final bool isLargeScreen = screenHeight > 800 && screenWidth > 450;
    return [
      Positioned(
        bottom: isLargeScreen ? -screenWidth * 0.5 : -screenWidth * 0.35,
        left: (screenWidth - circleSize) / 2,
        width: circleSize,
        height: circleSize,
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: primaryColor,
          ),
        ),
      ),
      Positioned(
        bottom: 0,
        child: Image.asset(
          "assets/images/menus/diver.png",
          width: screenWidth,
          height: screenHeight,
          fit: BoxFit.cover,
        ),
      )
    ];
  }

  /// Builds and item for the menu and displays it at the right position
  _buildMenuItem(double screenWidth, double bottomPosition, double leftPosition,
      String text, String image, Color textColor, Function navigateTo) {
    final double circleSize = screenWidth * 0.4;
    return Positioned(
      bottom: bottomPosition,
      left: leftPosition,
      width: circleSize,
      height: circleSize,
      child: Stack(
        children: [
          CircularText(
            children: [
              TextItem(
                text: Text(text, style: TextStyle(color: textColor)),
                startAngle: 180,
              ),
            ],
            radius: screenWidth * 0.25,
            position: CircularTextPosition.outside,
          ),
          ElevatedButton(
            onPressed: navigateTo,
            child: MyIcon(
              image: _IMAGE_FOLDER + image,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      AbstractTheme theme = themeProvider.theme;
      Color primaryColor = theme.themeData.primaryColor;
      return Scaffold(
        body: Stack(
          children: [
            ..._buildBackground(primaryColor, screenHeight, screenWidth),
            Positioned(
              top: screenHeight * 0.06,
              width: screenWidth,
              child: Text(
                "Le quizz du plongeur",
                style: TextStyle(fontSize: screenWidth * 0.1),
                textAlign: TextAlign.center,
              ),
            ),
            _buildMenuItem(
              screenWidth,
              screenHeight * 0.6,
              screenWidth * 0.53,
              "Apprendre les réactions",
              "reaction.jpg",
              theme.themeData.colorScheme.onSurface,
              () => _navigateTo(context, ReactionsQuizz()),
            ),
            _buildMenuItem(
              screenWidth,
              screenHeight * 0.45,
              screenWidth * 0.15,
              "Apprendre les signes",
              "sign.jpg",
              theme.themeData.colorScheme.onSurface,
              () => _navigateTo(context, SignsQuizz()),
            ),
            Positioned(
              bottom: screenHeight * 0.35,
              right: screenWidth * 0.15,
              child: ElevatedButton(
                onPressed: () => _navigateTo(context, MySettings()),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(screenWidth * 0.2, screenWidth * 0.2),
                ),
                child: Icon(
                  Icons.settings,
                  semanticLabel: "Paramètres",
                  color: Colors.black,
                  size: screenWidth * 0.15,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}
