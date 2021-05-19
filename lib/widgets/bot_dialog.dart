import "package:bubble/bubble.dart";
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';

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
          alignment: Alignment.topLeft,
          nip: BubbleNip.leftBottom,
          elevation: 0,
          color: themeProvider.theme.botBackgroundColor,
          margin: BubbleEdges.only(top: 8, right: 50),
          radius: Radius.circular(20),
          padding: BubbleEdges.symmetric(vertical: 10),
        ),
        child: this.child,
      );
    });
  }
}
