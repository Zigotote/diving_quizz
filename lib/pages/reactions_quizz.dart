import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/question.dart';
import '../providers/question_pool.dart';
import '../widgets/reaction_question.dart';
import '../widgets/sign_question.dart';
import 'abstract_quizz.dart';

class ReactionsQuizz extends AbstractQuizz {
  @override
  _ReactionsQuizzState createState() => _ReactionsQuizzState();
}

class _ReactionsQuizzState extends AbstractQuizzState {
  @override
  String get botImage => "assets/images/bots/shark.jpg";

  @override
  String get botName => "Sharky";

  @override
  List<String> get introDialog => [
        ...super.introDialog,
        "Je vais te montrer des signes. Tu devras trouver leur signification et la réaction adéquate.",
        "Prêt ?",
        "C'est sharky !"
      ];

  /// Adds a ReactionQuestion to the queue when current question has been answered
  void _addReactionQuestion(int score) {
    this.score += score;
    setState(() {
      Provider.of<QuestionPool>(context, listen: false)
          .addRandomReactionQuestion();
      needScroll = true;
    });
  }

  @override
  Widget buildQuestion(AbstractQuestionModel question) {
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
