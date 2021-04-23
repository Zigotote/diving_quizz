import 'package:diving_quizz/pages/reactions_quizz.dart';
import 'package:diving_quizz/pages/signs_quizz.dart';
import 'package:diving_quizz/providers/db_provider.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      DatabaseProvider.instance.close();
    }
  }

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
