import 'package:diving_quizz/widgets/question.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diving quizz',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Diving quizz"),
        ),
        body: Question(),
      ),
    );
  }
}
