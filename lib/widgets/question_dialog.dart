import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/widgets/answer_options.dart';
import 'package:diving_quizz/widgets/boot_dialog.dart';
import 'package:diving_quizz/widgets/user_dialog.dart';
import 'package:flutter/material.dart';

/// A dialog for a question.
/// The boot asks the question, the user can choose an answer and the boot says if it is the correct one
class QuestionDialog extends StatefulWidget {
  /// The question the boot asks
  final Question question;

  /// The answers the boot proposes
  final Set<String> answers;

  ///The function to call when the user has selected an answer
  final ValueChanged<int> onQuestionFinished;

  QuestionDialog(
      {@required this.question,
      @required this.answers,
      @required this.onQuestionFinished});

  @override
  _QuestionDialogState createState() => _QuestionDialogState();
}

class _QuestionDialogState extends State<QuestionDialog> {
  /// The widget which displays the answers. First it is an AnswerOptions widget.
  /// It becomes an UserDialog when the user has selected his response.
  Widget _answerWidget;

  @override
  void initState() {
    super.initState();
    _initAnswerWidget();
  }

  @override
  void didUpdateWidget(QuestionDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initAnswerWidget();
  }

  /// Inits the answer widget by setting it to an AnswerOption
  void _initAnswerWidget() {
    _answerWidget = AnswerOptions(
      onAnswerSelected: _handleAnswerSelected,
      answers: widget.answers,
    );
  }

  /// Changes the AnswerOptions widget by a UserDialog when the user has selected his answer.
  /// Generates the boot response, depending if the answer was correct or not.
  /// Gives a score to the player.
  void _handleAnswerSelected(String answer) {
    String bootResponse = "Non.";
    int score = 0;
    if (answer == widget.question.correctAnswer) {
      bootResponse = "Oui !";
      score = 1;
    }
    setState(() {
      _answerWidget = Column(
        children: [
          UserDialog(child: answer),
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
              image: AssetImage("assets/images/signs/" + widget.question.image),
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
