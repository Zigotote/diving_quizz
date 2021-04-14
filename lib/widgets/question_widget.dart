import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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

  /// Builds bubbles to display the user's answer and the bot's reponse
  Widget buildUserAnswerWidget();

  /// Builds a widget to display the available answers
  Widget buildAnswerOptions();

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
      answerWidget = buildUserAnswerWidget();
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
}
