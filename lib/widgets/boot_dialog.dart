import 'package:flutter/material.dart';
import "package:bubble/bubble.dart";

/// A dialog box from a boot. Placed on the left of the screen.
class BootDialog extends StatelessWidget {
  /// The widget to display in the bubble
  final Widget child;

  BootDialog({this.child});

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
