import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/question.dart';
import '../providers/question_pool.dart';
import '../widgets/back_button.dart';
import '../widgets/bot_dialog.dart';
import '../widgets/my_icon.dart';
import '../widgets/options_widget.dart';
import '../widgets/user_dialog.dart';

abstract class AbstractQuizz extends StatefulWidget {}

abstract class AbstractQuizzState extends State<AbstractQuizz> {
  /// The scroll controller for the page, to scroll automatically when height is overseized
  final ScrollController _scrollController = ScrollController();
  bool needScroll = false;

  /// The widget displaying the question to restart the quizz (or the answer the user selected)
  Widget _questionRelaunchQuizz;

  /// The indicator to know if the user has relaunched the same quizz or not
  bool _isRelaunched = false;

  /// The score of the user
  int score;

  AbstractQuizzState() {
    score = 0;
    _questionRelaunchQuizz = AnswerOptions(
        answers: {"Oui", "Non"}, onAnswerSelected: _handleRestartQuizz);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<QuestionPool>(context, listen: false).initQuizz();
  }

  /// Returns the name of the bot for the current quizz
  String get botName;

  /// Returns the picture of the bot
  String get botImage;

  /// Returns the text to put before the quizz
  List<String> get introDialog => [
        "Bonjour, moi c'est ${this.botName} !",
      ];

  /// Builds the quizz widget for the given question
  Widget buildQuestion(AbstractQuestionModel question);

  /// Adds a SignQuestion to the queue when current question has been answered
  /// The added question's type is from the type of U
  void addSignQuestion(int score) {
    this.score += score;
    setState(() {
      Provider.of<QuestionPool>(context, listen: false).addRandomSignQuestion();
      needScroll = true;
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

  /// Handles the response the user selected to restart the quizz or not
  _handleRestartQuizz(response) {
    if (response == "Oui") {
      setState(() {
        _isRelaunched = true;
        score = 0;
      });
      Provider.of<QuestionPool>(context, listen: false).initQuizz();
    } else {
      setState(() {
        _questionRelaunchQuizz = UserDialog(child: UserText(response));
      });
    }
  }

  /// Builds the end of the dialog, when the quizz is finished
  SliverList _buildEndDialog(QuestionPool questionPool) {
    int totalQuestions = questionPool.questions.length;
    return SliverList(
      delegate: SliverChildListDelegate(
        questionPool.isFinished
            ? [
                BotDialog(
                  child: Text(
                    "Le quizz est maintenant fini.",
                  ),
                ),
                BotDialog(
                  child: Text(
                    "Ton score est de $score/$totalQuestions.",
                  ),
                ),
                BotDialog(
                  child: Text(
                    "Veux-tu lancer un nouveau quizz ?",
                  ),
                ),
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return ScaleTransition(
                      child: child,
                      scale: animation,
                    );
                  },
                  child: _questionRelaunchQuizz,
                ),
              ]
            : [],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (needScroll) {
      _scrollToBottom();
      needScroll = false;
    }
    return Scaffold(
      appBar: AppBar(
        leading: MyBackButton(),
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: MyIcon(
                image: this.botImage,
                diameter: 45,
              ),
            ),
            Text("Professeur ${this.botName}"),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              _isRelaunched
                  ? [BotDialog(child: Text("C'est reparti !"))]
                  : introDialog
                      .map((text) => BotDialog(child: Text(text)))
                      .toList(),
            ),
          ),
          Consumer<QuestionPool>(
            builder: (context, questionPool, child) {
              final questions = questionPool.questions;
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index < questions.length) {
                      return buildQuestion(
                        questions.elementAt(index),
                      );
                    }
                    return null;
                  },
                ),
              );
            },
          ),
          Consumer<QuestionPool>(
            builder: (context, QuestionPool questionPool, child) {
              return _buildEndDialog(questionPool);
            },
          ),
        ],
      ),
    );
  }
}
