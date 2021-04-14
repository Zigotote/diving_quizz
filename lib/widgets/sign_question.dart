import 'package:diving_quizz/widgets/options_widget.dart';
import 'package:diving_quizz/widgets/question_widget.dart';
import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/theme/my_theme.dart';
import 'package:diving_quizz/widgets/bot_dialog.dart';
import 'package:diving_quizz/widgets/user_dialog.dart';
import 'package:flutter/material.dart';

/// A dialog for a question about the meaning of a sign.
/// The bot asks the question, the user can choose an answer and the bot says if it is the correct one
class SignQuestion extends QuestionWidget {
  SignQuestion({@required question, @required onQuestionFinished})
      : super(question: question, onQuestionFinished: onQuestionFinished);

  @override
  _SignQuestionState createState() => _SignQuestionState();
}

class _SignQuestionState extends QuestionWidgetState<SignQuestionModel> {
  @override
  Widget buildAnswerOptions() {
    return AnswerOptions(
      onAnswerSelected: handleAnswerSelected,
      answers: widget.question.proposedAnswers,
    );
  }

  @override
  Widget buildUserAnswerWidget() {
    String botResponse = "Oui !";
    if (!widget.question.isCorrectlyAnswered()) {
      botResponse =
          "Non, il s'agit de ${(widget.question as SignQuestionModel).signification}";
    }
    return Column(
      children: [
        UserDialog(
          child: Text(
            widget.question.userAnswer,
            style: TextStyle(
              color: MyTheme.userSecondaryColor,
            ),
          ),
        ),
        BotDialog(child: Text(botResponse))
      ],
    );
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
              image: AssetImage(widget.question.image),
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
            child: answerWidget,
          ),
        ],
      ),
    );
  }
}
