import 'package:diving_quizz/pages/home.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:diving_quizz/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => QuestionPool()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer(
        builder: (context, ThemeProvider themeProvider, _) {
          return MaterialApp(
            home: Home(),
            theme: themeProvider.theme.themeBrightness,
          );
        },
      ),
    );
  }
}
