import 'package:diving_quizz/theme/my_theme.dart';
import 'package:flutter/material.dart';

/// The list of possible reactions for a question
class ReactionOptions extends StatelessWidget {
  /// The possible reactions
  final Set<String> reactions;

  /// The function to call when the user has selected an answer
  final ValueChanged<String> onAnswerSelected;

  ReactionOptions({@required this.reactions, @required this.onAnswerSelected});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      children: this.reactions.map((reaction) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 6,
            vertical: 2,
          ),
          child: ElevatedButton(
            onPressed: () => this.onAnswerSelected(reaction),
            child: Image(
              image: AssetImage(reaction),
            ),
            style: ElevatedButton.styleFrom(
              onPrimary: MyTheme.userPrimaryColor, //font and icon color
              primary: MyTheme.userSecondaryColor, //background color
              elevation: 10,
            ),
          ),
        );
      }).toList(),
    );
  }
}
