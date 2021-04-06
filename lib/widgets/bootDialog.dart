import 'package:flutter/material.dart';
import "package:bubble/bubble.dart";

class BootDialog extends StatelessWidget {
  BootDialog({this.widget});

  final Widget widget;

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
      child: this.widget,
    );
  }
}
