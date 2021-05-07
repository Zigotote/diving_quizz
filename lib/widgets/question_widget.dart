import 'dart:math';

import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'bot_dialog.dart';
import 'user_dialog.dart';

/// A widget to manage the question's widget behaviour
abstract class QuestionWidget<T extends QuestionModel> extends StatefulWidget {
  /// The question the bot asks
  final T question;

  ///The function to call when the user has selected an answer
  final ValueChanged<int> onQuestionFinished;

  const QuestionWidget(
      {@required this.question, @required this.onQuestionFinished});
}

abstract class QuestionWidgetState<T extends QuestionModel>
    extends State<QuestionWidget> {
  /// The widget which displays the available answers or the user's response, depending on the question's state
  Widget answerWidget;

  /// Builds the question the bot asks
  List<Widget> buildQuestion();

  /// Builds a widget to display the available answers
  Widget buildAnswerOptions();

  /// Builds the answer the user has selected
  Widget buildUserAnswer();

  /// Builds the bot's responses to the user's answer
  List<Widget> buildBotResponses();

  @override
  void initState() {
    super.initState();
    _initAnswerWidget();
  }

  /// Rebuilds the widget when the user scrolls back to it
  @override
  void didUpdateWidget(QuestionWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _initAnswerWidget();
  }

  /// Creates a widget to display the answer to a question
  /// If the user has not answered the question, it displays the list of options
  /// Otherwise it builds its UserDialog bubble
  void _initAnswerWidget() {
    if (widget.question.userAnswer == null) {
      answerWidget = buildAnswerOptions();
    } else {
      _initUserAnswerWidget();
    }
  }

  /// Inits the answer widget by setting it to a dialog widget
  /// Adapts the bot's response if the user answered correctly or not
  void _initUserAnswerWidget() {
    setState(() {
      answerWidget = Column(
        children: [
          UserDialog(child: buildUserAnswer()),
          ...buildBotResponses().map((response) => BotDialog(child: response)),
        ],
      );
    });
  }

  /// Changes the ReactionOptions widget by a UserDialog when the user has selected his answer.
  /// Generates the bot response, depending if the answer was correct or not.
  /// Gives a score to the player.
  void handleAnswerSelected(String answer) {
    bool isCorrectAnswer = Provider.of<QuestionPool>(context, listen: false)
        .answerQuestion(widget.question, answer);
    int score = 0;
    if (isCorrectAnswer) {
      score = 1;
    }
    _initUserAnswerWidget();
    widget.onQuestionFinished(score);
  }

  /// Selects randomly a bot response when the user has selected the correct answer
  String selectBotResponse() {
    List<String> responses = [
      "Oui !",
      "Tout à fait.",
      "Bravo !",
      "Félicitations !",
      "C'est ça.",
      "Wahou, quel génie !",
      "Impressionnant !"
    ];
    Random randomNumber = new Random();
    int index = randomNumber.nextInt(responses.length);
    return responses.elementAt(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ...buildQuestion().map((question) => BotDialog(child: question)),
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
