import 'package:diving_quizz/providers/theme_provider.dart';
import 'package:diving_quizz/widgets/bot_dialog.dart';
import 'package:diving_quizz/widgets/options_widget.dart';
import 'package:diving_quizz/widgets/question_widget.dart';
import 'package:diving_quizz/models/question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
  List<Widget> buildQuestion() {
    return [
      BotText("Que signifie ce signe ?"),
      Image(
        image: AssetImage((widget.question as SignQuestionModel).image),
      )
    ];
  }

  @override
  Widget buildAnswerOptions() {
    return AnswerOptions(
      onAnswerSelected: handleAnswerSelected,
      answers: widget.question.proposedAnswers,
    );
  }

  @override
  Widget buildUserAnswer() {
    return Consumer(builder: (context, ThemeProvider themeProvider, child) {
      return Text(
        widget.question.userAnswer,
        style: TextStyle(
          color: themeProvider.theme.userSecondaryColor,
        ),
      );
    });
  }

  @override
  List<Widget> buildBotResponses() {
    List<Widget> botResponses = [BotText(this.selectBotResponse())];
    if (!widget.question.isCorrectlyAnswered()) {
      botResponses = [
        BotText(
          "Non, il s'agit de ${widget.question.signification}.",
        ),
        Text(
          "La réponse attendue était donc : ${widget.question.expectedAnswer}.",
        )
      ];
    }
    return botResponses;
  }
}
