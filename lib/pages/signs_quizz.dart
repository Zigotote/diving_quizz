import 'dart:convert';
import 'dart:math';

import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/widgets/question_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignsQuizz extends StatefulWidget {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends State<SignsQuizz> {
  /// The list of available questions
  List<Question> _questions = [];

  /// The list of questions asked by the boot
  List<QuestionDialog> _questionDialogs = [];

  /// The scroll controller for the page, to scroll automatically when height is overseized
  final ScrollController _scrollController = ScrollController();
  bool _needScroll = false;

  @override
  void initState() {
    super.initState();
    _readJson();
  }

  /// Reads the json file which contains all the available questions
  /// Initializes _questions and _questionDialogs
  Future<void> _readJson() async {
    final String response =
        await rootBundle.loadString("assets/data/signs_questions.json");
    final data = await json.decode(response);
    setState(() {
      _questions = (data["questions"] as List)
          .map((element) => new Question.fromJson(element))
          .toList();
      _addRandomQuestion();
    });
  }

  /// Choose a random question in the list
  /// Removes it and creates a dialog
  void _addRandomQuestion() {
    if (_questions.isNotEmpty) {
      var randomNumber = new Random();
      Question question =
          _questions.removeAt(randomNumber.nextInt(_questions.length));
      _questionDialogs.add(QuestionDialog(
        question: question,
        answers: {question.correctAnswer, "Je ne sais pas"},
        onQuestionFinished: _handleQuestionFinished,
      ));
    }
  }

  /// Adds a question to the queue when current question has been answered
  /// Modifies _needScroll value to handle a bottom scroll during render
  void _handleQuestionFinished(int score) {
    setState(() {
      _addRandomQuestion();
      _needScroll = true;
    });
  }

  /// Scrolls to the bottom of the screen after everything has been rendered
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_needScroll) {
      _needScroll = false;
      _scrollToBottom();
    }
    return MaterialApp(
      title: 'Diving quizz',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Diving quizz"),
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: _questionDialogs.length + 1,
          itemBuilder: (context, index) {
            // TODO To remove
            if (index == _questionDialogs.length) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _questionDialogs =
                        []; //TODO To remove when "reinitialiser" deleted
                    _readJson();
                  });
                },
                child: Text("reinitialiser"),
              );
            }
            return _questionDialogs[index];
          },
        ),
      ),
    );
  }
}
