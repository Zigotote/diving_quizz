import 'package:diving_quizz/pages/signs_quizz.dart';
import 'package:diving_quizz/widgets/question.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignsQuizz(),
    );
  }
}
