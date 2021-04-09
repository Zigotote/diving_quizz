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

  /// The answers the user has selected, saved in order to display it if the widget has to be reloaded
  /// (if the user wants to scroll back to previous answers)
  String _userAnswer;

  /// The boot's reaction to the user's answer, saved in order to display it if the widget has to be reloaded
  String _bootResponse;

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
    if (widget._userAnswer == null) {
      _initAnswerOptionsWidget();
    } else {
      _initUserAnswerWidget();
    }
  }

  @override
  void didUpdateWidget(QuestionDialog oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initAnswerOptionsWidget();
  }

  /// Inits the answer widget by setting it to an AnswerOption
  void _initAnswerOptionsWidget() {
    _answerWidget = AnswerOptions(
      onAnswerSelected: _handleAnswerSelected,
      answers: widget.answers,
    );
  }

  /// Inits the answer widget by setting it to a dialog widget, if the user has answered the question
  void _initUserAnswerWidget() {
    setState(() {
      _answerWidget = Column(
        children: [
          UserDialog(child: widget._userAnswer),
          BootDialog(child: Text(widget._bootResponse))
        ],
      );
    });
  }

  /// Changes the AnswerOptions widget by a UserDialog when the user has selected his answer.
  /// Generates the boot response, depending if the answer was correct or not.
  /// Gives a score to the player.
  void _handleAnswerSelected(String answer) {
    widget._userAnswer = answer;
    int score = 0;
    String bootResponse = "Non.";
    if (widget._userAnswer == widget.question.correctAnswer) {
      bootResponse = "Oui !";
      score = 1;
    }
    widget._bootResponse = bootResponse;
    _initUserAnswerWidget();
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
