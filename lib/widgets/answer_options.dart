import 'package:flutter/material.dart';

class AnswerOptions extends StatelessWidget {
  AnswerOptions({@required this.answers, @required this.onAnswerSelected});

  final Set<String> answers;
  final ValueChanged<String> onAnswerSelected;

  @override
  Widget build(BuildContext context) {
    List<Widget> answersWidget = [];
    answers.forEach((answer) {
      answersWidget.add(ElevatedButton(
        onPressed: () => this.onAnswerSelected(answer),
        child: Text(answer),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black, //font and icon color
          primary: Colors.white, //background color
          elevation: 10,
        ),
      ));
      answersWidget.add(SizedBox(
        width: 16.0,
      ));
    });
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: answersWidget,
    );
  }
}
