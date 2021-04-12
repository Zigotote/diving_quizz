import 'dart:collection';
import 'dart:math';

import 'package:diving_quizz/models/question.dart';
import 'package:flutter/cupertino.dart';

/// A provider for each dialog, to manage the question pool
class QuestionPool with ChangeNotifier {
  /// Questions asked by the bot and answered by the user
  List<QuestionModel> _questions = [];

  /// Questions the bot can ask
  List<QuestionModel> _availableQuestions = [];

  /// Answers the bot can propose
  Set<String> _possibleAnswers = {};

  UnmodifiableListView<QuestionModel> get questions =>
      UnmodifiableListView(_questions);

  /// Initializes the pool with a list of available question and the possible answers
  /// Adds a random question to the _question list to start the quizz
  void initQuestions(
    List<QuestionModel> availableQuestions,
    Set<String> possibleAnswers,
  ) {
    _availableQuestions = availableQuestions;
    _possibleAnswers = possibleAnswers;
    _questions = [];
    this.addRandomQuestion();
  }

  /// Chooses a random question and adds it to the _question list
  /// Creates a list of proposed answers for this question
  void addRandomQuestion() {
    if (_availableQuestions.isNotEmpty) {
      Random randomNumber = new Random();
      SignQuestionModel question = _availableQuestions
          .removeAt(randomNumber.nextInt(_availableQuestions.length));
      Set<String> possibleAnswers = _createAnswersList(question).toSet();
      question.proposedAnswers = possibleAnswers;
      _questions.add(question);
    }
    notifyListeners();
  }

  /// Creates the list of the proposed answers for a question
  /// Takes the correct answer and the suggestions. Adds some random answers from the other questions
  /// Shuffles the list to randomize the order of the answers
  List<String> _createAnswersList(QuestionModel question) {
    Random randomNumber = new Random();
    // Randomly choose one of the correct answers
    String correctAnswer = question.correctAnswers
        .elementAt(randomNumber.nextInt(question.correctAnswers.length));
    List<String> possibleAnswers = [
      correctAnswer,
      ...question.suggestedAnswers
    ];
    // Choose some incorrect answers to fill the list
    while (possibleAnswers.length < 4) {
      var answer = _possibleAnswers
          .where((answer) =>
              !possibleAnswers.contains(answer) &&
              !question.correctAnswers.contains(answer))
          .elementAt(randomNumber
              .nextInt(_possibleAnswers.length - possibleAnswers.length));
      possibleAnswers.add(answer);
    }
    // Randomizes the answer's order
    possibleAnswers.shuffle();
    return possibleAnswers;
  }

  /// Answers a question and returns true if it is the correct one
  bool answerQuestion(QuestionModel question, String answer) {
    final int questionIndex = _questions.indexOf(question);
    _questions[questionIndex].userAnswer = answer;
    notifyListeners();
    return question.isCorrectAnswer();
  }
}
