import 'package:diving_quizz/providers/theme_provider.dart';
import 'package:diving_quizz/widgets/my_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'reactions_quizz.dart';
import 'settings.dart';
import 'signs_quizz.dart';

class Home extends StatelessWidget {
  /// The folder where the item menu images are stored
  static const String _IMAGE_FOLDER = "assets/images/menus/";

  /// The fields to put in the menu
  final List<MenuItem> _menu = [
    MenuItem(
      text: "Apprendre les signes",
      image: _IMAGE_FOLDER + "sign.jpg",
      page: SignsQuizz(),
    ),
    MenuItem(
      text: "Apprendre les réactions",
      image: _IMAGE_FOLDER + "reaction.jpg",
      page: ReactionsQuizz(),
    )
  ];

  /// Navigates to another page
  void _navigateTo(context, StatefulWidget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Quizz du plongeur"),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings,
                semanticLabel: "Paramètres",
              ),
              iconSize: 35,
              onPressed: () => _navigateTo(context, MySettings()),
            ),
          ],
        ),
        body: Stack(
          children: [
            Positioned(
              bottom: screenHeight > 800 && screenWidth > 450
                  ? -screenWidth * 0.5
                  : -screenWidth * 0.35,
              left: screenWidth * 0.05,
              width: screenWidth * 0.9,
              height: screenWidth * 0.9,
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: themeProvider.theme.themeData.primaryColor,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                "assets/images/menus/plongeuse.png",
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      );
    });
  }
}

/// An item to display in the menu
class MenuItem {
  /// The text to display
  final String text;

  /// The image of the image
  final String image;

  /// The page the item is related to
  final StatefulWidget page;

  MenuItem({this.text, this.image, this.page});
}
