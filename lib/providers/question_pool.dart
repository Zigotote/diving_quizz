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
  Set<String> _possibleMeanings = {};

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
    _possibleMeanings = possibleAnswers;
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
        // Randomly choose one of the correct answers
        String correctMeaning = question.correctMeanings
            .elementAt(randomNumber.nextInt(question.correctMeanings.length));
        List<String> baseAnswers = [correctMeaning, ...question.trickMeanings];
        possibleAnswers =
            _createAnswersList(question, baseAnswers, _possibleMeanings);
      }
      if (question is ReactionQuestionModel) {
        possibleAnswers = _createAnswersList(
            question,
            [question.correctReaction, ...question.trickReactions],
            _possibleReactions);
      }
      question.proposedAnswers = possibleAnswers;
      _questions.add(question);
    }
    notifyListeners();
  }

  /// Creates the list of the proposed answers for a question
  /// Takes the correct answer and the suggestions. Adds some random answers from the other questions
  /// Shuffles the list to randomize the order of the answers
  Set<String> _createAnswersList(QuestionModel question,
      List<String> possibleAnswers, Set<String> availableAnswers) {
    Random randomNumber = new Random();
    // Choose some incorrect answers to fill the list
    while (possibleAnswers.length < 4) {
      var answer = availableAnswers
          .where((answer) =>
              !possibleAnswers.contains(answer) &&
              !question.isCorrectAnswer(answer))
          .elementAt(randomNumber
              .nextInt(availableAnswers.length - possibleAnswers.length));
      possibleAnswers.add(answer);
    }
    // Randomizes the answer's order
    possibleAnswers.shuffle();
    return possibleAnswers.toSet();
  }

  /// Answers a question and returns true if it is the correct one
  bool answerQuestion(QuestionModel question, String answer) {
    final int questionIndex = _questions.indexOf(question);
    _questions[questionIndex].userAnswer = answer;
    notifyListeners();
    return question.isCorrectlyAnswered();
  }
}
