import 'dart:convert';
import 'dart:math';

import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/question_list.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignsQuizz extends StatefulWidget {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends State<SignsQuizz> {
  /// The list of available questions
  List<Question> _questions = [];

  /// The list of the answers that can be proposed to the user
  List<String> _possibleAnswers = [];

  @override
  void initState() {
    super.initState();
    _readJson();
  }

  /// Reads the json file which contains all the available questions
  /// Initializes the lists used to build the questions
  /// Initializes the current question's list with one question
  Future<void> _readJson() async {
    final String response =
        await rootBundle.loadString("assets/data/signs_questions.json");
    final data = await json.decode(response);
    setState(() {
      Provider.of<QuestionPool>(context, listen: false).reset();
      _questions = (data["questions"] as List)
          .map((element) => new Question.fromJson(element))
          .toList();
      _possibleAnswers = [];
      _questions.forEach(
          (question) => _possibleAnswers.addAll(question.correctAnswers));
      _addRandomQuestion();
    });
  }

  /// Choose a random question in the list
  /// Removes it and creates a dialog
  void _addRandomQuestion() {
    if (_questions.isNotEmpty) {
      Random randomNumber = new Random();
      Question question =
          _questions.removeAt(randomNumber.nextInt(_questions.length));
      List<String> possibleAnswers = _createAnswersList(question);
      Provider.of<QuestionPool>(context, listen: false).addQuestion(
        SignQuestion(
          question: question,
          answers: possibleAnswers.toSet(),
          onQuestionFinished: _handleQuestionFinished,
        ),
      );
    }
  }

  /// Creates the list of the proposed answers for a question
  /// Takes the correct answer and the suggestions. Adds some random answers from the other questions
  /// Shuffles the list to randomize the order of the answers
  List<String> _createAnswersList(Question question) {
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

  /// Adds a question to the queue when current question has been answered
  void _handleQuestionFinished(int score) {
    setState(() {
      _addRandomQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage("assets/images/teachers/axolotl.png"),
                  ),
                ),
              ),
            ),
            Text("Professeur Axolotl"),
          ],
        ),
      ),
      body: Column(
        children: [
          Consumer<QuestionPool>(
            builder: (context, questions, child) =>
                QuestionList(questions: questions.questions),
          ),
          ElevatedButton(
            onPressed: () => this._readJson(),
            child: Text("Réinitialiser"),
          )
        ],
      ),
    );
  }
}
