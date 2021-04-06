import 'package:flutter/material.dart';
import "package:bubble/bubble.dart";

class UserDialog extends StatelessWidget {
  UserDialog({this.widget});

  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Bubble(
      style: BubbleStyle(
        nip: BubbleNip.rightCenter,
        elevation: 4,
        margin: BubbleEdges.only(top: 4),
        alignment: Alignment.topRight,
      ),
      child: this.widget,
    );
  }
}
