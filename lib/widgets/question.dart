import 'package:diving_quizz/widgets/bootDialog.dart';
import 'package:diving_quizz/widgets/userDialog.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  // TODO To uncomment when many questions
  // Question({this.image});

  final image = "ok.png";
  final answers = {"OK", "I don't know"};

  bool _answerSelected = false;
  String _answerText = "";

  /// Builds the row to display the possible answers
  Widget _buildAnswers() {
    List<Widget> answersWidget = [];
    answers.forEach((answer) {
      answersWidget.add(ElevatedButton(
        onPressed: () {
          setState(() {
            _answerSelected = true;
            _answerText = answer;
          });
        },
        child: Text(answer),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black, //font and icon color
          primary: Colors.white, //background color
          elevation: 10,
        ),
      ));
      answersWidget.add(SizedBox(
        width: 16.0,
      ));
    });
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: answersWidget,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BootDialog(
            widget: Text("Que signifie ce signe ?"),
          ),
          BootDialog(
            widget: Image(
              image: AssetImage("assets/signs/" + this.image),
            ),
          ),
          Visibility(
            visible: this._answerSelected,
            child: UserDialog(
              widget: Text(
                this._answerText,
              ),
            ),
          ),
          Visibility(
            visible: !this._answerSelected,
            child: this._buildAnswers(),
          ),
        ],
      ),
    );
  }
}
