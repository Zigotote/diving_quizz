class Question {
  final String image;
  final String correctAnswer;
  final Set<String> suggestedAnswers;

  Question(this.image, this.correctAnswer, this.suggestedAnswers);

  Question.fromJson(Map<String, dynamic> json)
      : image = json["image"],
        correctAnswer = json["correctAnswer"],
        suggestedAnswers = json["suggestedAnswers"];
}
