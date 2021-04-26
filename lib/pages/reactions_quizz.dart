import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/pages/base_quizz.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/reaction_question.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ReactionsQuizz extends BaseQuizz {
  @override
  _ReactionsQuizzState createState() => _ReactionsQuizzState();
}

class _ReactionsQuizzState extends BaseQuizzState {
  @override
  String get botImage => "assets/images/bots/shark.jpg";

  @override
  String get botName => "Sharky";

  /// Adds a ReactionQuestion to the queue when current question has been answered
  void _addReactionQuestion(int score) {
    setState(() {
      Provider.of<QuestionPool>(context, listen: false)
          .addRandomReactionQuestion();
      needScroll = true;
    });
  }

  @override
  Widget buildQuestion(QuestionModel question) {
    if (question is SignQuestionModel) {
      return SignQuestion(
        question: question,
        onQuestionFinished: _addReactionQuestion,
      );
    }
    if (question is ReactionQuestionModel) {
      return ReactionQuestion(
        question: question,
        onQuestionFinished: addSignQuestion,
      );
    }
    return Container();
  }
}
