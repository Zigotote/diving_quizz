abstract class QuestionModel {
  /// The image the user has to know
  final String image;

  /// The answers the bot proposes
  Set<String> proposedAnswers;

  /// The answer the user has selected
  String userAnswer;

  QuestionModel(this.image);

  QuestionModel.fromJson(Map<String, dynamic> json)
      : image = "assets/images/signs/" + json["image"],
        proposedAnswers = {};

  /// Checks if the answer is correct
  bool isCorrectAnswer(String answer);

  /// Checks if the user has correctly answered the question
  bool isCorrectlyAnswered();
}

/// A QuestionModel to learn the meaning of a sign
class SignQuestionModel extends QuestionModel {
  /// The expected answers
  final Set<String> correctAnswers;

  /// The suggested answer, if the sign is similar to others their meaning can be added to this Set to make the QuestionModel harder
  final Set<String> suggestedAnswers;

  SignQuestionModel(String image, this.correctAnswers, this.suggestedAnswers)
      : super(image);

  SignQuestionModel.fromJson(Map<String, dynamic> json)
      : correctAnswers = Set.from(json["correctAnswers"]),
        suggestedAnswers = json["suggestedAnswers"] != null
            ? Set.from(json["suggestedAnswers"])
            : {},
        super.fromJson(json);

  @override
  bool isCorrectlyAnswered() => this.correctAnswers.contains(this.userAnswer);

  @override
  bool isCorrectAnswer(String answer) => this.correctAnswers.contains(answer);
}

/// A QuestionModel to learn the meaning of a sign and the reaction to apply to it
class ReactionQuestionModel extends QuestionModel {
  /// The expected reaction to produce after the sign
  final String correctReaction;

  ReactionQuestionModel(
    String image,
    this.correctReaction,
  ) : super(image);

  ReactionQuestionModel.fromJson(Map<String, dynamic> json)
      : correctReaction = "assets/images/signs/" + json["correctReaction"],
        super.fromJson(json);

  @override
  bool isCorrectlyAnswered() => this.userAnswer == this.correctReaction;

  @override
  bool isCorrectAnswer(String answer) => answer == this.correctReaction;
}
