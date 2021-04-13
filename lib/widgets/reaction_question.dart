import 'package:diving_quizz/widgets/options_widget.dart';
import 'package:diving_quizz/widgets/question_widget.dart';
import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/widgets/bot_dialog.dart';
import 'package:diving_quizz/widgets/user_dialog.dart';
import 'package:flutter/material.dart';

/// A dialog for a question about the reaction to apply to a sign.
/// The bot asks the question, the user can choose an answer and the bot says if it is the correct one
class ReactionQuestion extends QuestionWidget {
  ReactionQuestion({@required question, @required onQuestionFinished})
      : super(question: question, onQuestionFinished: onQuestionFinished);

  @override
  _ReactionQuestionState createState() => _ReactionQuestionState();
}

class _ReactionQuestionState
    extends QuestionWidgetState<ReactionQuestionModel> {
  @override
  Widget buildAnswerOptions() {
    return ReactionOptions(
      onAnswerSelected: handleAnswerSelected,
      reactions: widget.question.proposedAnswers,
    );
  }

  @override
  Widget buildUserAnswerWidget(String botResponse) {
    return Column(
      children: [
        UserDialog(
          child: Image(
            image: AssetImage(widget.question.userAnswer),
          ),
        ),
        BotDialog(child: Text(botResponse))
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          BotDialog(
            child: Text("Comment y réagir ?"),
          ),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(
                child: child,
                scale: animation,
              );
            },
            child: answerWidget,
          ),
        ],
      ),
    );
  }
}
