import 'package:diving_quizz/theme/my_theme.dart';
import 'package:flutter/material.dart';
import "package:bubble/bubble.dart";

/// A dialog box from the user. Placed on the right of the screen.
class UserDialog extends StatelessWidget {
  /// The widget to display in the bubble
  final String child;

  UserDialog({this.child});

  @override
  Widget build(BuildContext context) {
    return Bubble(
      style: BubbleStyle(
        nip: BubbleNip.rightCenter,
        elevation: 4,
        color: MyTheme.userPrimaryColor,
        margin: BubbleEdges.only(top: 4),
        alignment: Alignment.topRight,
      ),
      child: Text(
        this.child,
        style: TextStyle(
          color: MyTheme.userSecondaryColor,
        ),
      ),
    );
  }
}
