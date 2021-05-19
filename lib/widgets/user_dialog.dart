import "package:bubble/bubble.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

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
          alignment: Alignment.topRight,
          nip: BubbleNip.rightBottom,
          elevation: 0,
          color: themeProvider.theme.userPrimaryColor,
          margin: BubbleEdges.only(top: 4),
          radius: Radius.circular(20),
          padding: BubbleEdges.symmetric(vertical: 10),
        ),
        child: this.child,
      );
    });
  }
}

/// A text to display in a UserDialog
class UserText extends StatelessWidget {
  /// The text to display
  final String text;

  UserText(this.text);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      return Text(
        this.text,
        style: TextStyle(
          color: themeProvider.theme.userSecondaryColor,
        ),
      );
    });
  }
}
