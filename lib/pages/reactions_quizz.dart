import 'dart:convert';

import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/pages/base_quizz.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/reaction_question.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ReactionsQuizz extends BaseQuizz {
  @override
  _ReactionsQuizzState createState() => _ReactionsQuizzState();
}

class _ReactionsQuizzState extends BaseQuizzState {
  @override
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("assets/data/reactions_questions.json");
    final data = await json.decode(response);
    final List<SignQuestionModel> signQuestions = (data["questions"] as List)
        .map((element) => new SignQuestionModel.fromJson(element))
        .toList();
    Set<String> possibleAnswers = {};
    signQuestions
        .forEach((question) => possibleAnswers.addAll(question.correctAnswers));
    final List<ReactionQuestionModel> reactionQuestions =
        (data["questions"] as List)
            .map((element) => new ReactionQuestionModel.fromJson(element))
            .toList();
    Set<String> possibleReactions = {};
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString("AssetManifest.json");
    possibleReactions = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith("assets/images/signs"))
        .toSet();
    setState(() {
      Provider.of<QuestionPool>(context, listen: false).initQuestions(
          [...reactionQuestions, ...signQuestions],
          possibleAnswers,
          possibleReactions);
    });
  }

  @override
  String botImage() {
    return "assets/images/bots/shark.jpg";
  }

  @override
  String botName() {
    return "Professeur Sharky";
  }

  /// Adds a ReactionQuestion to the queue when current question has been answered
  /// The added question's type is from the type of U
  void _addReactionQuestion(int score) {
    setState(() {
      Provider.of<QuestionPool>(context, listen: false)
          .addRandomQuestion<ReactionQuestionModel>();
      needScroll = true;
    });
  }

  @override
  Widget buildQuestion(QuestionPool questionPool, int index) {
    QuestionModel question = questionPool.questions[index];
    if (question is SignQuestionModel) {
      return SignQuestion(
        question: questionPool.questions[index],
        onQuestionFinished: _addReactionQuestion,
      );
    }
    if (question is ReactionQuestionModel) {
      return ReactionQuestion(
        question: questionPool.questions[index],
        onQuestionFinished: addSignQuestion,
      );
    }
    return Container();
  }
}
