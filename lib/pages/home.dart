import 'package:diving_quizz/pages/reactions_quizz.dart';
import 'package:diving_quizz/pages/signs_quizz.dart';
import 'package:diving_quizz/widgets/my_icon.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  /// The folder where the item menu images are stored
  static const String _IMAGE_FOLDER = "assets/images/menus/";

  /// The fields to put in the menu
  final List<MenuItem> _menu = [
    MenuItem(
      text: "Apprendre les signes",
      image: _IMAGE_FOLDER + "sign.jpg",
      page: SignsQuizz(),
      backgroundColor: Colors.cyan,
    ),
    MenuItem(
      text: "Apprendre les réactions",
      image: _IMAGE_FOLDER + "reaction.jpg",
      page: ReactionsQuizz(),
      backgroundColor: Colors.indigo, //Colors.lightBlue or blue
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Quizz du plongeur"),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return GridView.count(
            crossAxisCount: orientation == Orientation.portrait ? 2 : 3,
            crossAxisSpacing: 2,
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            children: _menu
                .map(
                  (item) => Container(
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            MyIcon(
                              image: item.image,
                              diameter: 100,
                            ),
                            Text(
                              item.text,
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                      ),
                      onPressed: () => this._navigateTo(context, item.page),
                      style: ElevatedButton.styleFrom(
                        //onPrimary: MyTheme.userPrimaryColor, //font and icon color
                        primary: item.backgroundColor, //background color
                        elevation: 10,
                      ),
                    ),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
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

  /// The background color of the item
  final MaterialColor backgroundColor;

  MenuItem({this.text, this.image, this.page, this.backgroundColor});
}
