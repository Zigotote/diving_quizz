import 'dart:convert';

import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/reaction_question.dart';
import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ReactionsQuizz extends StatefulWidget {
  @override
  _ReactionsQuizzState createState() => _ReactionsQuizzState();
}

class _ReactionsQuizzState extends State<ReactionsQuizz> {
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
        await rootBundle.loadString("assets/data/reactions_questions.json");
    final data = await json.decode(response);
    final List<SignQuestionModel> signQuestions = (data["questions"] as List)
        .map((element) => new SignQuestionModel.fromJson(element))
        .toList();
    Set<String> possibleAnswers = {};
    signQuestions
        .forEach((question) => possibleAnswers.addAll(question.correctAnswers));
    final List<ReactionQuestionModel> reactionQuestions =
        (data["questions"] as List)
            .map((element) => new ReactionQuestionModel.fromJson(element))
            .toList();
    Set<String> possibleReactions = {};
    final manifestJson =
        await DefaultAssetBundle.of(context).loadString("AssetManifest.json");
    possibleReactions = json
        .decode(manifestJson)
        .keys
        .where((String key) => key.startsWith("assets/images/signs"))
        .toSet();
    setState(() {
      Provider.of<QuestionPool>(context, listen: false).initQuestions(
          [...reactionQuestions, ...signQuestions],
          possibleAnswers,
          possibleReactions);
    });
  }

  /// Adds a reaction question to the queue when current question has been answered
  void _handleSignQuestionFinished(int score) {
    setState(() {
      Provider.of<QuestionPool>(context, listen: false)
          .addRandomQuestion<ReactionQuestionModel>();
      _needScroll = true;
    });
  }

  /// Adds a sign question to the queue when current question has been answered
  void _handleReactionQuestionFinished(int score) {
    setState(() {
      Provider.of<QuestionPool>(context, listen: false)
          .addRandomQuestion<SignQuestionModel>();
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
                  itemBuilder: (context, index) {
                    Widget child;
                    if (questionPool.questions[index] is SignQuestionModel) {
                      child = SignQuestion(
                        question: questionPool.questions[index],
                        onQuestionFinished: _handleSignQuestionFinished,
                      );
                    } else {
                      child = ReactionQuestion(
                        question: questionPool.questions[index],
                        onQuestionFinished: _handleReactionQuestionFinished,
                      );
                    }
                    return Column(
                      children: [child],
                    );
                  }),
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
