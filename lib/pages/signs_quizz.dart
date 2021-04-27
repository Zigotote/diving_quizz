import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/pages/base_quizz.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';

class SignsQuizz extends BaseQuizz {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends BaseQuizzState {
  @override
  String get botImage => "assets/images/bots/axolotl.png";

  @override
  String get botName => "Axel";

  @override
  List<String> get introDialog => [
        ...super.introDialog,
        "Nous allons travailler les signes de plongée ensemble.",
        "Sauras-tu trouver les significations des signes que je vais te présenter ?",
      ];

  @override
  Widget buildQuestion(QuestionModel question) {
    return SignQuestion(
      question: question,
      onQuestionFinished: addSignQuestion,
    );
  }
}
