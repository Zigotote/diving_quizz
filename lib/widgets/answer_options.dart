import 'package:flutter/material.dart';

/// The list of possible answers for a question
class AnswerOptions extends StatelessWidget {
  /// The possible answers
  final Set<String> answers;

  /// The function to call when the user has selected an answer
  final ValueChanged<String> onAnswerSelected;

  AnswerOptions({@required this.answers, @required this.onAnswerSelected});

  /// Build the widget to display the answers
  /// Each answer is a button. They are seperated by blank boxes
  List<Widget> _buildAnswersWidget() {
    List<Widget> answerWidgets = [];
    this.answers.forEach((answer) {
      answerWidgets.add(ElevatedButton(
        onPressed: () => this.onAnswerSelected(answer),
        child: Text(answer),
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.black, //font and icon color
          primary: Colors.white, //background color
          elevation: 10,
        ),
      ));
      answerWidgets.add(SizedBox(
        width: 16.0,
      ));
    });
    return answerWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: _buildAnswersWidget(),
    );
  }
}
