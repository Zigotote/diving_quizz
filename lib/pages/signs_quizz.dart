import 'dart:convert';

import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/pages/base_quizz.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignsQuizz extends BaseQuizz {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends BaseQuizzState {
  /// Reads the json file which contains all the available questions
  /// Initializes the lists used to build the questions
  /// Initializes the current question's list with one question
  Future<void> readJson() async {
    final String response =
        await rootBundle.loadString("assets/data/signs_questions.json");
    final data = await json.decode(response);
    final List<SignQuestionModel> questions = (data["questions"] as List)
        .map((element) => new SignQuestionModel.fromJson(element))
        .toList();
    Set<String> possibleAnswers = {};
    questions
        .forEach((question) => possibleAnswers.addAll(question.correctAnswers));
    setState(() {
      Provider.of<QuestionPool>(context, listen: false)
          .initQuestions(questions, possibleAnswers);
    });
  }

  @override
  String botImage() {
    return "assets/images/bots/axolotl.png";
  }

  @override
  String botName() {
    return "Professeur Axel";
  }

  @override
  Widget buildQuestion(QuestionPool questionPool, int index) {
    return SignQuestion(
      question: questionPool.questions[index],
      onQuestionFinished: addSignQuestion,
    );
  }
}
