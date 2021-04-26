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
  String get botName => "Professeur Axel";

  @override
  Widget buildQuestion(QuestionModel question) {
    return SignQuestion(
      question: question,
      onQuestionFinished: addSignQuestion,
    );
  }
}
