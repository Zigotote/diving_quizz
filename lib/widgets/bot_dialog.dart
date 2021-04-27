import 'package:diving_quizz/theme/my_theme.dart';
import 'package:flutter/material.dart';
import "package:bubble/bubble.dart";

/// A dialog box from a bot. Placed on the left of the screen.
class BotDialog extends StatelessWidget {
  /// The widget to display in the bubble
  final Widget child;

  BotDialog({this.child});

  @override
  Widget build(BuildContext context) {
    return Bubble(
      style: BubbleStyle(
        nip: BubbleNip.leftCenter,
        color: Theme.of(context).colorScheme.botBackgroundColor,
        elevation: 4,
        margin: BubbleEdges.only(top: 8, right: 50),
        alignment: Alignment.topLeft,
      ),
      child: this.child,
    );
  }
}

/// A text to display in a BotDialog
class BotText extends StatelessWidget {
  /// The text to display
  final String text;

  BotText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      this.text,
      style: TextStyle(
        color: Theme.of(context).colorScheme.botFontColor,
      ),
    );
  }
}
