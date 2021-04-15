import 'package:diving_quizz/providers/question_pool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

abstract class BaseQuizz extends StatefulWidget {}

abstract class BaseQuizzState extends State<BaseQuizz> {
  /// The scroll controller for the page, to scroll automatically when height is overseized
  final ScrollController scrollController = ScrollController();
  bool needScroll = false;

  @override
  void initState() {
    super.initState();
    Provider.of<QuestionPool>(context, listen: false).initQuizz();
  }

  /// Returns the name of the bot for the current quizz
  String botName();

  /// Returns the picture of the bot
  String botImage();

  /// Builds the quizz widget for the question at the given index of the questionPool
  Widget buildQuestion(QuestionPool questionPool, int index);

  /// Adds a SignQuestion to the queue when current question has been answered
  /// The added question's type is from the type of U
  void addSignQuestion(int score) {
    setState(() {
      Provider.of<QuestionPool>(context, listen: false).addRandomQuestion();
      needScroll = true;
    });
  }

  /// Scrolls to the bottom of the screen after everything has been rendered
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
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
              child: Container(
                width: 45,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(this.botImage()),
                  ),
                ),
              ),
            ),
            Text(this.botName()),
          ],
        ),
      ),
      body: Column(
        children: [
          Consumer<QuestionPool>(builder: (context, questionPool, child) {
            return Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: questionPool.questions.length,
                itemBuilder: (context, index) =>
                    buildQuestion(questionPool, index),
              ),
            );
          }),
          ElevatedButton(
            onPressed:
                Provider.of<QuestionPool>(context, listen: false).initQuizz,
            child: Text("Réinitialiser"),
          )
        ],
      ),
    );
  }
}
