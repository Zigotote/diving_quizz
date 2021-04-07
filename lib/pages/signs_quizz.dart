import 'package:diving_quizz/widgets/question_dialog.dart';
import 'package:flutter/material.dart';

class SignsQuizz extends StatefulWidget {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends State<SignsQuizz> {
  List<QuestionDialog> _questions = [];
  final ScrollController _scrollController = ScrollController();
  bool _needScroll = false;

  @override
  void initState() {
    super.initState();
    _questions.add(
      QuestionDialog(
        image: "ok.png",
        correctAnswer: "OK",
        answers: {"OK", "Je ne sais pas"},
        onQuestionFinished: _handleQuestionFinished,
      ),
    );
  }

  void _handleQuestionFinished(int score) {
    setState(() {
      _questions.add(
        QuestionDialog(
          image: "ok.png",
          correctAnswer: "OK",
          answers: {"OK", "Je ne sais pas"},
          onQuestionFinished: _handleQuestionFinished,
        ),
      );
      _needScroll = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_needScroll) {
      _needScroll = false;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOut,
        );
      });
    }
    return MaterialApp(
      title: 'Diving quizz',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Diving quizz"),
        ),
        body: ListView.builder(
          controller: _scrollController,
          itemCount: _questions.length + 1,
          itemBuilder: (context, index) {
            // TODO To remove
            if (index == _questions.length) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    _questions = [
                      QuestionDialog(
                        image: "ok.png",
                        correctAnswer: "OK",
                        answers: {"OK", "Je ne sais pas"},
                        onQuestionFinished: _handleQuestionFinished,
                      ),
                    ];
                  });
                },
                child: Text("reinitialiser"),
              );
            }
            return _questions[index];
          },
        ),
      ),
    );
  }
}
