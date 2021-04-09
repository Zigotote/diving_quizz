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
        color: Colors.lightBlue.shade50,
        elevation: 4,
        margin: BubbleEdges.only(top: 8, right: 50),
        alignment: Alignment.topLeft,
      ),
      child: this.child,
    );
  }
}
