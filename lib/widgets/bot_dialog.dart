import 'package:diving_quizz/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import "package:bubble/bubble.dart";
import 'package:provider/provider.dart';

/// A dialog box from a bot. Placed on the left of the screen.
class BotDialog extends StatelessWidget {
  /// The widget to display in the bubble
  final Widget child;

  BotDialog({this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      return Bubble(
        style: BubbleStyle(
          nip: BubbleNip.leftCenter,
          color: themeProvider.theme.botBackgroundColor,
          elevation: 4,
          margin: BubbleEdges.only(top: 8, right: 50),
          alignment: Alignment.topLeft,
        ),
        child: this.child,
      );
    });
  }
}

/// A text to display in a BotDialog
class BotText extends StatelessWidget {
  /// The text to display
  final String text;

  BotText(this.text);

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      return Text(
        this.text,
        style: TextStyle(
          color: themeProvider.theme.textColor,
        ),
      );
    });
  }
}
