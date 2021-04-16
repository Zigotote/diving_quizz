import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:diving_quizz/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A provider for each dialog, to manage the question pool
class QuestionPool with ChangeNotifier {
  /// Questions asked by the bot and answered by the user
  List<QuestionModel> _askedQuestions = [];

  /// Questions the bot hasn't already asked
  List<SignQuestionModel> _availableQuestions = [];

  /// Answers the bot can propose
  Set<String> _possibleMeanings = {};

  /// Reactions the bot can propose
  Set<String> _possibleReactions = {};

  UnmodifiableListView<QuestionModel> get questions =>
      UnmodifiableListView(_askedQuestions);

  /// Reads the json file which contains all the available questions
  /// Initializes the lists used to build the questions
  /// Initializes the current question's list with one question
  void initQuizz() async {
    final String response =
        await rootBundle.loadString("assets/data/questions.json");
    final data = await json.decode(response);
    _availableQuestions = (data["questions"] as List)
        .map((element) => new SignQuestionModel.fromJson(element))
        .toList();
    _askedQuestions = [];
    if (_possibleMeanings.isEmpty && _possibleReactions.isEmpty) {
      _availableQuestions.forEach((question) {
        _possibleMeanings.addAll(question.correctMeanings);
        _possibleMeanings.addAll(question.trickMeanings);
      });
      final manifestJson = await rootBundle.loadString("AssetManifest.json");
      _possibleReactions = json
          .decode(manifestJson)
          .keys
          .where((String key) => key.startsWith("assets/images/signs"))
          .toSet();
    }
    addRandomSignQuestion();
  }

  /// Chooses a random sign question and adds it to the _question list
  /// Creates a list of proposed answers for this question
  void addRandomSignQuestion() {
    if (_availableQuestions.isNotEmpty) {
      Random randomNumber = new Random();
      SignQuestionModel question = _availableQuestions
          .removeAt(randomNumber.nextInt(_availableQuestions.length));
      _availableQuestions.remove(question);
      // Randomly choose one of the correct answers
      String correctMeaning = question.correctMeanings
          .elementAt(randomNumber.nextInt(question.correctMeanings.length));
      List<String> baseAnswers = [correctMeaning, ...question.trickMeanings];
      Set<String> possibleAnswers = _createAnswersList(
          question,
          baseAnswers,
          _possibleMeanings
              .where((answer) =>
                  !baseAnswers.contains(answer) &&
                  !question.isCorrectAnswer(answer))
              .toList());
      question.proposedAnswers = possibleAnswers;
      _askedQuestions.add(question);
    }
    notifyListeners();
  }

  /// Creates a random ReactionQuestion from the expected answer to the last SignQuestion.
  /// If the answer didn't need reaction, it creates a SignQuestion
  /// Otherwise it choose one of the expected reactions and creates a question with it
  void addRandomReactionQuestion() {
    SignQuestionModel lastQuestion = _askedQuestions.last;
    String correctAnswer = lastQuestion.proposedAnswers
        .firstWhere((answer) => lastQuestion.isCorrectAnswer(answer));
    List<ReactionQuestionModel> reactions =
        lastQuestion.associatedReactions[correctAnswer];
    Set<String> reactionAnswers =
        reactions.map((reaction) => reaction.correctReaction).toSet();

    /// Puts the signQuestion in the _availableQuestions list without the previous selected meaning as an answer
    if (lastQuestion.associatedReactions.length > 1) {
      _availableQuestions.add(lastQuestion.duplicate(correctAnswer));
    }
    if (reactions.isEmpty) {
      addRandomSignQuestion();
    } else {
      Random randomNumber = new Random();
      ReactionQuestionModel question =
          reactions.removeAt(randomNumber.nextInt(reactions.length));
      // Randomly choose one of the correct answers
      String correctMeaning = question.correctReaction;
      List<String> baseAnswers = [correctMeaning, ...question.trickReactions];
      Set<String> possibleAnswers = _createAnswersList(
          question,
          baseAnswers,
          _possibleReactions
              .where((answer) =>
                  !baseAnswers.contains(answer) &&
                  !reactionAnswers.contains(answer))
              .toList());
      question.proposedAnswers = possibleAnswers;
      _askedQuestions.add(question);
    }
  }

  /// Creates the list of the proposed answers for a question
  /// Takes the correct answer and the suggestions. Adds some random answers from the other questions
  /// Shuffles the list to randomize the order of the answers
  Set<String> _createAnswersList(QuestionModel question,
      List<String> possibleAnswers, List<String> availableAnswers) {
    Random randomNumber = new Random();
    // Choose some incorrect answers to fill the list
    while (possibleAnswers.length < 4) {
      var answer = availableAnswers
          .removeAt(randomNumber.nextInt(availableAnswers.length));
      possibleAnswers.add(answer);
    }
    // Randomizes the answer's order
    possibleAnswers.shuffle();
    return possibleAnswers.toSet();
  }

  /// Answers a question and returns true if it is the correct one
  bool answerQuestion(QuestionModel question, String answer) {
    final int questionIndex = _askedQuestions.indexOf(question);
    _askedQuestions[questionIndex].userAnswer = answer;
    notifyListeners();
    return question.isCorrectlyAnswered();
  }
}
