import 'package:diving_quizz/widgets/answerOptions.dart';
import 'package:diving_quizz/widgets/bootDialog.dart';
import 'package:diving_quizz/widgets/userDialog.dart';
import 'package:flutter/material.dart';

class Question extends StatefulWidget {
  final String image;
  final String correctAnswer;
  final Set<String> answers;

  Question({
    @required this.image,
    @required this.correctAnswer,
    @required this.answers,
  });

  @override
  _QuestionState createState() => _QuestionState();
}

class _QuestionState extends State<Question> {
  Widget _answerWidget;

  @override
  void initState() {
    super.initState();
    this._answerWidget = AnswerOptions(
      onAnswerSelected: this._handleAnswerSelected,
      answers: widget.answers,
    );
  }

  void _handleAnswerSelected(String answer) {
    var bootResponse = "Non.";
    if (answer == widget.correctAnswer) {
      bootResponse = "Oui !";
    }
    setState(() {
      this._answerWidget = Column(children: [
        UserDialog(child: Text(answer)),
        BootDialog(child: Text(bootResponse))
      ]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BootDialog(
            child: Text("Que signifie ce signe ?"),
          ),
          BootDialog(
            child: Image(
              image: AssetImage("assets/signs/" + widget.image),
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
          //TODO To remove
          ElevatedButton(
            onPressed: () {
              setState(() {
                this._answerWidget = AnswerOptions(
                  onAnswerSelected: this._handleAnswerSelected,
                  answers: widget.answers,
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
