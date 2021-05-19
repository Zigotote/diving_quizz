import 'package:flutter/material.dart';

/// A list of possible options for a question
abstract class AbstractOptionsWidget extends StatelessWidget {
  /// The possible answers
  final Set<String> answers;

  /// The function to call when the user has selected an answer
  final ValueChanged<String> onAnswerSelected;

  AbstractOptionsWidget(
      {@required this.answers, @required this.onAnswerSelected});

  /// Builds the Widget to display the answer
  Widget buildAnswer(String answer);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: this.answers.map((answer) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: OutlinedButton(
            onPressed: () => this.onAnswerSelected(answer),
            child: this.buildAnswer(answer),
          ),
        );
      }).toList(),
    );
  }
}

/// The list of possible answers for a question
class AnswerOptions extends AbstractOptionsWidget {
  AnswerOptions({@required answers, @required onAnswerSelected})
      : super(answers: answers, onAnswerSelected: onAnswerSelected);

  @override
  Widget buildAnswer(String answer) {
    return Text(answer);
  }
}

/// The list of possible reactions for a question
class ReactionOptions extends AbstractOptionsWidget {
  ReactionOptions({@required reactions, @required onAnswerSelected})
      : super(answers: reactions, onAnswerSelected: onAnswerSelected);

  @override
  Widget buildAnswer(String reaction) {
    return Image(
      image: AssetImage(reaction),
    );
  }
}
