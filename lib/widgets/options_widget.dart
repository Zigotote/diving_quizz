import 'package:diving_quizz/theme/my_theme.dart';
import 'package:flutter/material.dart';

/// A list of possible options for a question
abstract class OptionsWidget extends StatelessWidget {
  /// The possible answers
  final Set<String> answers;

  /// The function to call when the user has selected an answer
  final ValueChanged<String> onAnswerSelected;

  OptionsWidget({@required this.answers, @required this.onAnswerSelected});

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
          child: ElevatedButton(
            onPressed: () => this.onAnswerSelected(answer),
            child: this.buildAnswer(answer),
            style: ElevatedButton.styleFrom(
              onPrimary: Theme.of(context)
                  .colorScheme
                  .userPrimaryColor, //font and icon color
              primary: Theme.of(context)
                  .colorScheme
                  .userSecondaryColor, //background color
              elevation: 10,
            ),
          ),
        );
      }).toList(),
    );
  }
}

/// The list of possible answers for a question
class AnswerOptions extends OptionsWidget {
  AnswerOptions({@required answers, @required onAnswerSelected})
      : super(answers: answers, onAnswerSelected: onAnswerSelected);

  @override
  Widget buildAnswer(String answer) {
    return Text(answer);
  }
}

/// The list of possible reactions for a question
class ReactionOptions extends OptionsWidget {
  ReactionOptions({@required reactions, @required onAnswerSelected})
      : super(answers: reactions, onAnswerSelected: onAnswerSelected);

  @override
  Widget buildAnswer(String reaction) {
    return Image(
      image: AssetImage(reaction),
    );
  }
}
