import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/answer_options.dart';
import 'package:diving_quizz/widgets/bot_dialog.dart';
import 'package:diving_quizz/widgets/user_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A dialog for a question about the meaning of a sign.
/// The bot asks the question, the user can choose an answer and the bot says if it is the correct one
class SignQuestion extends StatefulWidget {
  /// The question the bot asks
  final SignQuestionModel question;

  ///The function to call when the user has selected an answer
  final ValueChanged<int> onQuestionFinished;

  SignQuestion({@required this.question, @required this.onQuestionFinished});

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
    _initAnswerWidget();
  }

  /// Rebuilds the widget when the user scrolls back to it
  @override
  void didUpdateWidget(SignQuestion oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initAnswerWidget();
  }

  /// Inits the answer's widget.
  /// If the user has not answered the question it creates an AnswerOptionsWidget.
  /// Otherwise it creates a UserDialog
  void _initAnswerWidget() {
    if (widget.question.userAnswer == null) {
      _answerWidget = AnswerOptions(
        onAnswerSelected: _handleAnswerSelected,
        answers: widget.question.proposedAnswers,
      );
    } else {
      _initUserAnswerWidget();
    }
  }

  /// Inits the answer widget by setting it to a dialog widget, if the user has answered the question
  void _initUserAnswerWidget() {
    String botResponse = "Non.";
    if (widget.question.isCorrectAnswer()) {
      botResponse = "Oui !";
    }
    setState(() {
      _answerWidget = Column(
        children: [
          UserDialog(child: widget.question.userAnswer),
          BotDialog(child: Text(botResponse))
        ],
      );
    });
  }

  /// Changes the AnswerOptions widget by a UserDialog when the user has selected his answer.
  /// Generates the bot response, depending if the answer was correct or not.
  /// Gives a score to the player.
  void _handleAnswerSelected(String answer) {
    bool isCorrectAnswer = Provider.of<QuestionPool>(context, listen: false)
        .answerQuestion(widget.question, answer);
    int score = 0;
    if (isCorrectAnswer) {
      score = 1;
    }
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
