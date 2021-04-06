import 'package:diving_quizz/widgets/bootDialog.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  // TODO To uncomment when many questions
  // Question({this.image});

  final image = "ok.png";
  final _answersStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.black, //font and icon color
    primary: Colors.white, //background color
    elevation: 10,
  ); //https://codesinsider.com/flutter-elevatedbutton-example/

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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: () => print("hello"),
                child: Text("OK"),
                style: this._answersStyle,
              ),
              SizedBox(
                width: 16.0,
              ),
              ElevatedButton(
                onPressed: () => print("I don't know"),
                child: Text("I don't know"),
                style: this._answersStyle,
              ),
            ],
          )
        ],
      ),
    );
  }
}
