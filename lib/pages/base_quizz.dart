import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/widgets/bot_dialog.dart';
import 'package:diving_quizz/widgets/my_icon.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseQuizz extends StatefulWidget {}

abstract class BaseQuizzState extends State<BaseQuizz> {
  /// The scroll controller for the page, to scroll automatically when height is overseized
  final ScrollController _scrollController = ScrollController();
  bool needScroll = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Provider.of<QuestionPool>(context, listen: false).initQuizz();
  }

  /// Returns the name of the bot for the current quizz
  String get botName;

  /// Returns the picture of the bot
  String get botImage;

  /// Builds the quizz widget for the given question
  Widget buildQuestion(QuestionModel question);

  /// Adds a SignQuestion to the queue when current question has been answered
  /// The added question's type is from the type of U
  void addSignQuestion(int score) {
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

  @override
  Widget build(BuildContext context) {
    if (needScroll) {
      _scrollToBottom();
      needScroll = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Padding(
              padding: EdgeInsets.only(right: 8),
              child: MyIcon(
                image: this.botImage,
                diameter: 45,
              ),
            ),
            Text(this.botName),
          ],
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverList(
            delegate: SliverChildListDelegate(
              [
                BotDialog(child: Text("Bonjour")),
                BotDialog(child: Text("Je suis " + botName)),
              ],
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
        ],
      ),
      bottomNavigationBar: ElevatedButton(
        onPressed: Provider.of<QuestionPool>(context, listen: false).initQuizz,
        child: Text("Réinitialiser"),
      ),
    );
  }
}
