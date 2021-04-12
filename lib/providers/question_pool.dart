import 'dart:collection';

import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/cupertino.dart';

/// A provider for each dialog, to manage the question pool
class QuestionPool with ChangeNotifier {
  /// Questions asked by the bot and answered by the user
  List<SignQuestion> _questions = [];

  UnmodifiableListView<SignQuestion> get questions =>
      UnmodifiableListView(_questions);

  /// Adds a question to the list
  void addQuestion(SignQuestion question) {
    _questions.add(question);
    notifyListeners();
  }

  /// Answers a question
  void answerQuestion(SignQuestion question, String answer) {
    final int questionIndex = _questions.indexOf(question);
    SignQuestion myQuestion = _questions[questionIndex];
    myQuestion.userAnswer = answer;
    if (myQuestion.question.correctAnswers.contains(answer)) {
      myQuestion.botResponse = "Oui!";
    } else {
      myQuestion.botResponse = "Non.";
    }
    notifyListeners();
  }

  /// Erases all the questions from the list
  void reset() {
    _questions = [];
    notifyListeners();
  }
}
