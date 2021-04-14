import 'package:diving_quizz/pages/reactions_quizz.dart';
import 'package:diving_quizz/pages/signs_quizz.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diving quizz"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
              child: Text("Lancer le quizz facile !"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SignsQuizz(),
                  ),
                );
              },
            ),
          ),
          Center(
            child: ElevatedButton(
              child: Text("Lancer le quizz difficile !"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ReactionsQuizz(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
