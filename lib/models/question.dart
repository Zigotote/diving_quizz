class Question {
  /// The image the user has to know
  final String image;

  /// The expected answers
  final Set<String> correctAnswers;

  /// The suggested answer, if the sign is similar to others their meaning can be added to this Set to make the question harder
  final Set<String> suggestedAnswers;

  Question(this.image, this.correctAnswers, this.suggestedAnswers);

  Question.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        correctAnswers = Set.from(json["correctAnswers"]),
        suggestedAnswers = json["suggestedAnswers"] != null
            ? Set.from(json["suggestedAnswers"])
            : {};
}
