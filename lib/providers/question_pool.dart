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

  /// Reactions the bot can propose
  Set<String> _possibleReactions = {};

  UnmodifiableListView<QuestionModel> get questions =>
      UnmodifiableListView(_questions);

  /// Initializes the pool with a list of available question and the possible answers
  /// Adds a random question to the _question list to start the quizz
  void initQuestions(
      List<QuestionModel> availableQuestions, Set<String> possibleAnswers,
      [Set<String> possibleReactions]) {
    _availableQuestions = availableQuestions;
    _possibleAnswers = possibleAnswers;
    _possibleReactions = possibleReactions;
    _questions = [];
    this.addRandomQuestion<SignQuestionModel>();
  }

  /// Chooses a random question and adds it to the _question list
  /// Creates a list of proposed answers for this question
  void addRandomQuestion<T extends QuestionModel>() {
    List<T> filteredQuestions = _availableQuestions.whereType<T>().toList();
    if (filteredQuestions.isNotEmpty) {
      Random randomNumber = new Random();
      T question = filteredQuestions
          .removeAt(randomNumber.nextInt(filteredQuestions.length));
      _availableQuestions.remove(question);
      Set<String> possibleAnswers = {};
      if (question is SignQuestionModel) {
        possibleAnswers = _createAnswersList(question).toSet();
      }
      if (question is ReactionQuestionModel) {
        possibleAnswers = _createReactionsList(question).toSet();
      }
      question.proposedAnswers = possibleAnswers;
      _questions.add(question);
    }
    notifyListeners();
  }

  /// Creates the list of the proposed answers for a question
  /// Takes the correct answer and the suggestions. Adds some random answers from the other questions
  /// Shuffles the list to randomize the order of the answers
  List<String> _createAnswersList(SignQuestionModel question) {
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

  /// Creates the list of the proposed reactions for a question
  /// Takes the correct reaction and adds some random answers from the other questions
  /// Shuffles the list to randomize the order of the answers
  List<String> _createReactionsList(ReactionQuestionModel question) {
    Random randomNumber = new Random();
    List<String> possibleReactions = [question.correctReaction];
    // Choose some incorrect answers to fill the list
    while (possibleReactions.length < 4) {
      var answer = _possibleReactions
          .where((answer) => !possibleReactions.contains(answer))
          .elementAt(randomNumber
              .nextInt(_possibleReactions.length - possibleReactions.length));
      possibleReactions.add(answer);
    }
    // Randomizes the answer's order
    possibleReactions.shuffle();
    return possibleReactions;
  }

  /// Answers a question and returns true if it is the correct one
  bool answerQuestion(QuestionModel question, String answer) {
    final int questionIndex = _questions.indexOf(question);
    _questions[questionIndex].userAnswer = answer;
    notifyListeners();
    return question.isCorrectAnswer();
  }
}
