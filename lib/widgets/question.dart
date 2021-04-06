import 'package:diving_quizz/widgets/answerOptions.dart';
import 'package:diving_quizz/widgets/bootDialog.dart';
import 'package:diving_quizz/widgets/userDialog.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Widget _answerWidget;
  final String image = "ok.png";
  final Set<String> answers = {"OK", "I don't know"};

  @override
  void initState() {
    super.initState();
    this._answerWidget = AnswerOptions(
      onAnswerSelected: this._handleAnswerSelected,
      answers: this.answers,
    );
  }

  void _handleAnswerSelected(String answer) {
    setState(() {
      this._answerWidget = UserDialog(widget: Text(answer));
    });
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
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                child: child,
                scale: animation,
              );
            },
            child: this._answerWidget,
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                this._answerWidget = AnswerOptions(
                  onAnswerSelected: this._handleAnswerSelected,
                  answers: this.answers,
                );
              });
            },
            child: Text("reinitialiser"),
          )
        ],
      ),
    );
  }
}
