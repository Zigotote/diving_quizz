import 'package:diving_quizz/widgets/bootDialog.dart';
import 'package:diving_quizz/widgets/userDialog.dart';
import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  // TODO To uncomment when many questions
  // Question({this.image});

  final image = "ok.png";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        padding: EdgeInsets.all(8),
        children: [
          BootDialog(
            widget: Text("Que signifie ce signe ?"),
          ),
          BootDialog(
            widget: Image(
              image: AssetImage("assets/signs/" + this.image),
            ),
          ),
          UserDialog(
            widget: Text("I don't know"),
          )
        ],
      ),
    );
  }
}
