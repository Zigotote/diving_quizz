import 'package:diving_quizz/pages/signs_quizz.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diving quizz"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Lancer le quizz !"),
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
    );
  }
}
