import 'dart:convert';

import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class SignsQuizz extends StatefulWidget {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends State<SignsQuizz> {
  /// The scroll controller for the page, to scroll automatically when height is overseized
  final ScrollController _scrollController = ScrollController();
  bool _needScroll = false;

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
    final List<SignQuestionModel> questions = (data["questions"] as List)
        .map((element) => new SignQuestionModel.fromJson(element))
        .toList();
    Set<String> possibleAnswers = {};
    questions
        .forEach((question) => possibleAnswers.addAll(question.correctAnswers));
    setState(() {
      Provider.of<QuestionPool>(context, listen: false)
          .initQuestions(questions, possibleAnswers);
    });
  }

  /// Adds a question to the queue when current question has been answered
  void _handleQuestionFinished(int score) {
    setState(() {
      Provider.of<QuestionPool>(context, listen: false).addRandomQuestion();
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
      _scrollToBottom();
      _needScroll = false;
    }
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
          Consumer<QuestionPool>(builder: (context, questionPool, child) {
            return Expanded(
              child: ListView.builder(
                controller: _scrollController,
                itemCount: questionPool.questions.length,
                itemBuilder: (context, index) => SignQuestion(
                  question: questionPool.questions[index],
                  onQuestionFinished: _handleQuestionFinished,
                ),
              ),
            );
          }),
          ElevatedButton(
            onPressed: () => this._readJson(),
            child: Text("Réinitialiser"),
          )
        ],
      ),
    );
  }
}
