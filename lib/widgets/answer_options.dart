import 'package:flutter/material.dart';

/// The list of possible answers for a question
class AnswerOptions extends StatelessWidget {
  /// The possible answers
  final Set<String> answers;

  /// The function to call when the user has selected an answer
  final ValueChanged<String> onAnswerSelected;

  AnswerOptions({@required this.answers, @required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: this.answers.map((answer) {
        return Padding(
          padding: EdgeInsets.fromLTRB(8.0, 4, 8.0, 0),
          child: ElevatedButton(
            onPressed: () => this.onAnswerSelected(answer),
            child: Text(answer),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.black, //font and icon color
              primary: Colors.white, //background color
              elevation: 10,
            ),
          ),
        );
      }).toList(),
    );
  }
}
