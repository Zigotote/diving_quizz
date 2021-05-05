import 'package:diving_quizz/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import "package:bubble/bubble.dart";
import 'package:provider/provider.dart';

/// A dialog box from the user. Placed on the right of the screen.
class UserDialog extends StatelessWidget {
  /// The widget to display in the bubble
  final Widget child;

  UserDialog({this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      return Bubble(
        style: BubbleStyle(
          nip: BubbleNip.rightCenter,
          elevation: 4,
          color: themeProvider.theme.userPrimaryColor,
          margin: BubbleEdges.only(top: 4),
          alignment: Alignment.topRight,
        ),
        child: this.child,
      );
    });
  }
}
