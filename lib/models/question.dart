abstract class QuestionModel {
  /// The image the user has to know
  final String image;

  /// The expected answers
  final Set<String> correctAnswers;

  /// The suggested answer, if the sign is similar to others their meaning can be added to this Set to make the QuestionModel harder
  final Set<String> suggestedAnswers;

  /// The answer the user has selected
  String userAnswer;

  QuestionModel(this.image, this.correctAnswers, this.suggestedAnswers);

  QuestionModel.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        correctAnswers = Set.from(json["correctAnswers"]),
        suggestedAnswers = json["suggestedAnswers"] != null
            ? Set.from(json["suggestedAnswers"])
            : {};

  /// Checks if the user has correctly answered the question
  bool isCorrectAnswer();
}

/// A QuestionModel to learn the meaning of a sign
class SignQuestionModel extends QuestionModel {
  /// The answers the bot proposes
  Set<String> proposedAnswers;

  SignQuestionModel(
    String image,
    Set<String> correctAnswers,
    Set<String> suggestedAnswers,
  ) : super(image, correctAnswers, suggestedAnswers);

  SignQuestionModel.fromJson(Map<String, dynamic> json)
      : proposedAnswers = {},
        super.fromJson(json);

  @override
  bool isCorrectAnswer() => this.correctAnswers.contains(this.userAnswer);
}
