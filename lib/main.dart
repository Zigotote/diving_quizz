import 'package:diving_quizz/pages/home.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => QuestionPool(),
      child: MaterialApp(
        home: Home(),
      ),
    );
  }
}
