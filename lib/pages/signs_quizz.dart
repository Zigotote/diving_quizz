import 'package:diving_quizz/widgets/question.dart';
import 'package:flutter/material.dart';

class SignsQuizz extends StatefulWidget {
  @override
  _SignsQuizzState createState() => _SignsQuizzState();
}

class _SignsQuizzState extends State<SignsQuizz> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diving quizz',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Diving quizz"),
        ),
        body: Question(
          image: "ok.png",
          correctAnswer: "OK",
          answers: {"OK", "Je ne sais pas"},
        ),
      ),
    );
  }
}
