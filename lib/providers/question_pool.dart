import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:diving_quizz/models/question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'db_provider.dart';

/// A provider for each dialog, to manage the question pool
class QuestionPool with ChangeNotifier {
  /// Questions asked by the bot and answered by the user
  List<AbstractQuestionModel> _askedQuestions = [];

  /// The ids of the questions the bot hasn't already asked, linked to their failure rate
  Map<int, int> _availableQuestionIds = {};

  /// The ids of the meanings the bot hasn't already proposed (for the reaction questions)
  List<int> _availableMeaningIds = [];

  /// The id of the last asked meaning
  static int lastMeaningId;

  /// Answers the bot can propose
  Set<String> _possibleMeanings = {};

  /// Reactions the bot can propose
  Set<String> _possibleReactions = {};

  UnmodifiableListView<AbstractQuestionModel> get questions =>
      UnmodifiableListView(_askedQuestions);

  QuestionPool() {
    _fillPossibleMeanings();
    _fillPossibleReactions();
  }

  /// Fills the _possibleMeanings list with the meanings of all the questions
  Future _fillPossibleMeanings() async {
    _possibleMeanings = await DatabaseProvider.instance.getMeanings();
  }

  /// Fills the _possibleReactions list with the signs saved in the assets folder
  Future _fillPossibleReactions() async {
    final String manifestJson =
        await rootBundle.loadString("AssetManifest.json");
    _possibleReactions = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith("assets/images/signs"))
        .toSet();
  }

  /// Reads the json file which contains all the available questions
  /// Initializes the lists used to build the questions
  /// Initializes the current question's list with one question
  void initQuizz() async {
    _askedQuestions = [];
    _availableQuestionIds =
        await DatabaseProvider.instance.getSignQuestionIds();
    _availableMeaningIds = await DatabaseProvider.instance.getMeaningIds();
    addRandomSignQuestion();
  }

  /// Chooses a random sign question and adds it to the _question list
  /// Creates a list of proposed answers for this question
  void addRandomSignQuestion() async {
    if (_availableQuestionIds.isNotEmpty) {
      int questionId = _selectRandomQuestion(_availableQuestionIds.entries);
      _availableQuestionIds.remove(questionId);
      SignQuestionModel question =
          await DatabaseProvider.instance.getSignQuestion(questionId);
      question.removeMeanings(_availableMeaningIds);
      // Randomly choose one of the correct answers
      Random randomNumber = new Random();
      String correctMeaning = question.correctMeanings
          .elementAt(randomNumber.nextInt(question.correctMeanings.length));
      lastMeaningId = question.getMeaningFromText(correctMeaning).id;
      _availableMeaningIds.remove(lastMeaningId);

      List<String> baseAnswers = [correctMeaning, ...question.tricks];
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
    List<ReactionQuestionModel> reactions =
        lastQuestion.getMeaning(lastMeaningId).reactions;
    Set<String> reactionAnswers =
        reactions.map((reaction) => reaction.correctReaction).toSet();

    /// Puts the signQuestion in the _availableQuestions list with the updated failureRate
    if (lastQuestion.meanings.length > 1) {
      _availableQuestionIds[lastQuestion.id] = lastQuestion.failureRate;
    }
    if (reactions.isEmpty) {
      addRandomSignQuestion();
    } else {
      int questionId = _selectRandomQuestion(
          reactions.map((e) => MapEntry(e.id, e.failureRate)));
      ReactionQuestionModel question =
          reactions.firstWhere((reaction) => reaction.id == questionId);
      // Randomly choose one of the correct answers
      String correctMeaning = question.correctReaction;
      List<String> baseAnswers = [correctMeaning, ...question.tricks];
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
      notifyListeners();
    }
  }

  /// Answers a question and returns true if it is the correct one
  bool answerQuestion(AbstractQuestionModel question, String answer) {
    final int questionIndex = _askedQuestions.indexOf(question);
    _askedQuestions[questionIndex].setUserAnswer(answer);
    notifyListeners();
    return question.isCorrectlyAnswered();
  }

  /// Creates the list of the proposed answers for a question
  /// Takes the correct answer and the suggestions. Adds some random answers from the other questions
  /// Shuffles the list to randomize the order of the answers
  Set<String> _createAnswersList(AbstractQuestionModel question,
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

  /// Randomly selects a question in the list, weight by the failure rates
  int _selectRandomQuestion(Iterable<MapEntry<int, int>> questions) {
    int total = questions.fold(
        0, (previousValue, element) => previousValue + element.value);
    Random randomNumber = new Random();
    int index = -1;
    if (total == 0) {
      index = randomNumber.nextInt(questions.length);
    } else {
      int selectedIndex = randomNumber.nextInt(total);
      int tmpSum = 0;
      while (tmpSum < selectedIndex) {
        index++;
        tmpSum += questions.elementAt(index).value;
      }
    }
    return questions.elementAt(max(0, index)).key;
  }
}
