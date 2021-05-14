import 'package:diving_quizz/models/question.dart';
import 'package:flutter/material.dart';

import 'options_widget.dart';
import 'abstract_question.dart';

/// A dialog for a question about the reaction to apply to a sign.
/// The bot asks the question, the user can choose an answer and the bot says if it is the correct one
class ReactionQuestion extends AbstractQuestionWidget {
  ReactionQuestion({@required question, @required onQuestionFinished})
      : super(question: question, onQuestionFinished: onQuestionFinished);

  @override
  _ReactionQuestionState createState() => _ReactionQuestionState();
}

class _ReactionQuestionState
    extends AbstractQuestionWidgetState<ReactionQuestionModel> {
  @override
  List<Widget> buildQuestion() {
    return [Text("Comment y réagir ?")];
  }

  @override
  Widget buildAnswerOptions() {
    return ReactionOptions(
      onAnswerSelected: handleAnswerSelected,
      reactions: widget.question.proposedAnswers,
    );
  }

  @override
  Widget buildUserAnswer() {
    return Image(
      image: AssetImage(widget.question.userAnswer),
    );
  }

  @override
  List<Widget> buildBotResponses() {
    List<Widget> botResponses = [Text(this.selectBotResponse())];
    if (!widget.question.isCorrectlyAnswered()) {
      botResponses = [
        Text(
          "Non, il fallait répondre \"${widget.question.signification}\" avec ce signe :",
        ),
        Image(
          image: AssetImage(widget.question.expectedAnswer),
        )
      ];
    }
    return botResponses;
  }
}
