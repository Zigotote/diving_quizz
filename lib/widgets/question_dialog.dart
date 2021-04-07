import 'package:diving_quizz/widgets/answer_options.dart';
import 'package:diving_quizz/widgets/boot_dialog.dart';
import 'package:diving_quizz/widgets/user_dialog.dart';
import 'package:flutter/material.dart';

class QuestionDialog extends StatefulWidget {
  final String image;
  final String correctAnswer;
  final Set<String> answers;
  final ValueChanged<int> onQuestionFinished;

  QuestionDialog(
      {@required this.image,
      @required this.correctAnswer,
      @required this.answers,
      @required this.onQuestionFinished});

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  Widget _answerWidget;

  @override
  void initState() {
    super.initState();
    _answerWidget = AnswerOptions(
      onAnswerSelected: _handleAnswerSelected,
      answers: widget.answers,
    );
  }

  void _handleAnswerSelected(String answer) {
    var bootResponse = "Non.";
    var score = 0;
    if (answer == widget.correctAnswer) {
      bootResponse = "Oui !";
      score = 1;
    }
    setState(() {
      _answerWidget = Column(
        children: [
          UserDialog(child: Text(answer)),
          BootDialog(child: Text(bootResponse))
        ],
      );
    });
    widget.onQuestionFinished(score);
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
              image: AssetImage("assets/images/signs/" + widget.image),
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
            child: _answerWidget,
          ),
        ],
      ),
    );
  }
}
