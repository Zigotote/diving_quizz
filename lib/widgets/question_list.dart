import 'package:diving_quizz/widgets/sign_question.dart';
import 'package:flutter/cupertino.dart';

/// A list of question asked to the user
class QuestionList extends StatelessWidget {
  /// List of questions to display
  final List<SignQuestion> questions;

  /// The scroll controller for the page, to scroll automatically when height is overseized
  final ScrollController _scrollController = ScrollController();

  QuestionList({@required this.questions});

  /// Scrolls to the bottom of the screen after everything has been rendered
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    _scrollToBottom();
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: questions.length,
        itemBuilder: (context, index) => questions[index],
      ),
    );
  }
}
