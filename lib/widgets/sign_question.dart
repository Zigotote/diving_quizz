import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/widgets/answer_options.dart';
import 'package:diving_quizz/widgets/bot_dialog.dart';
import 'package:diving_quizz/widgets/user_dialog.dart';
import 'package:flutter/material.dart';

/// A dialog for a question about the meaning of a sign.
/// The bot asks the question, the user can choose an answer and the bot says if it is the correct one
class SignQuestion extends StatefulWidget {
  /// The question the bot asks
  final Question question;

  /// The answers the bot proposes
  final Set<String> answers;

  ///The function to call when the user has selected an answer
  final ValueChanged<int> onQuestionFinished;

  /// The answers the user has selected, saved in order to display it if the widget has to be reloaded
  /// (if the user wants to scroll back to previous answers)
  String _userAnswer;

  /// The bot's reaction to the user's answer, saved in order to display it if the widget has to be reloaded
  String _botResponse;

  SignQuestion(
      {@required this.question,
      @required this.answers,
      @required this.onQuestionFinished});

  @override
  _SignQuestionState createState() => _SignQuestionState();
}

class _SignQuestionState extends State<SignQuestion> {
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
  void didUpdateWidget(SignQuestion oldWidget) {
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
          BotDialog(child: Text(widget._botResponse))
        ],
      );
    });
  }

  /// Changes the AnswerOptions widget by a UserDialog when the user has selected his answer.
  /// Generates the bot response, depending if the answer was correct or not.
  /// Gives a score to the player.
  void _handleAnswerSelected(String answer) {
    widget._userAnswer = answer;
    int score = 0;
    String botResponse = "Non.";
    if (widget.question.correctAnswers.contains(widget._userAnswer)) {
      botResponse = "Oui !";
      score = 1;
    }
    widget._botResponse = botResponse;
    _initUserAnswerWidget();
    widget.onQuestionFinished(score);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BotDialog(
            child: Text("Que signifie ce signe ?"),
          ),
          BotDialog(
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
