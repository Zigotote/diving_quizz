class Question {
  /// The image the user has to know
  final String image;

  /// The expected answer
  final String correctAnswer;

  /// The suggested answer, if the sign is similar to others their meaning can be added to this Set to make the question harder
  final Set<String> suggestedAnswers;

  Question(this.image, this.correctAnswer, this.suggestedAnswers);

  Question.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        correctAnswer = json["correctAnswer"],
        suggestedAnswers = json["suggestedAnswers"];
}
