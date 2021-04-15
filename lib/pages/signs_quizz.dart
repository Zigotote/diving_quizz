import 'package:diving_quizz/pages/base_quizz.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';

class SignsQuizz extends BaseQuizz {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends BaseQuizzState {
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
