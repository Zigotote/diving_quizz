abstract class QuestionModel {
  static const String _IMAGE_FOLDER = "assets/images/signs/";

  /// The explained signification of the expected answer
  final String signification;

  /// The answers the bot proposes
  Set<String> proposedAnswers = {};

  /// The answer the user has selected
  String userAnswer;

  QuestionModel(this.signification);

  QuestionModel.fromJson(Map<String, dynamic> json)
      : signification = json["signification"];

  /// Checks if the answer is correct
  bool isCorrectAnswer(String answer);

  /// Checks if the user has correctly answered the question
  bool isCorrectlyAnswered();
}

/// A QuestionModel to learn the meaning of a sign
class SignQuestionModel extends QuestionModel {
  /// The image the user has to know
  final String image;

  /// The different meanings of the sign, linked to their associated reactions
  final Map<String, List<ReactionQuestionModel>> associatedReactions;

  /// The trick answer, if the sign is similar to others their meaning can be added to this Set to make the QuestionModel harder
  final Set<String> trickMeanings;

  SignQuestionModel(this.image, String signification, this.associatedReactions,
      this.trickMeanings)
      : super(signification);

  SignQuestionModel.fromJson(Map<String, dynamic> json)
      : image = QuestionModel._IMAGE_FOLDER + json["image"],
        associatedReactions =
            Map<String, List<ReactionQuestionModel>>.fromIterable(
          json["meanings"],
          key: (meaning) => meaning["text"],
          value: (meaning) => meaning["reactions"] == null
              ? []
              : List.of(meaning["reactions"]).map(
                  (reaction) {
                    reaction["trickReactions"] = meaning["trickReactions"];
                    return ReactionQuestionModel.fromJson(reaction);
                  },
                ).toList(),
        ),
        trickMeanings = json["trickMeanings"] != null
            ? Set.from(json["trickMeanings"])
            : {},
        super.fromJson(json);

  /// Returns the correct meanings for the question
  Set<String> get correctMeanings => associatedReactions.keys.toSet();

  @override
  bool isCorrectlyAnswered() => this.correctMeanings.contains(this.userAnswer);

  @override
  bool isCorrectAnswer(String answer) => this.correctMeanings.contains(answer);

  @override
  String toString() {
    String str = "${this.image} -> ${this.userAnswer} \n";
    this.associatedReactions.forEach((key, value) {
      str += "$key : [${value.join(",")}] \n";
    });
    return str;
  }
}

/// A QuestionModel to learn the meaning of a sign and the reaction to apply to it
class ReactionQuestionModel extends QuestionModel {
  /// The expected reaction to produce after the sign
  final String correctReaction;

  /// The trick reaction, if the sign is similar to others their reactions can be added to this Set to make the QuestionModel harder
  final Set<String> trickReactions;

  ReactionQuestionModel(
      String signification, this.correctReaction, this.trickReactions)
      : super(signification);

  ReactionQuestionModel.fromJson(Map<String, dynamic> json)
      : correctReaction = QuestionModel._IMAGE_FOLDER + json["image"],
        trickReactions = json["trickReactions"] != null
            ? Set.from(json["trickReactions"]
                .map((image) => QuestionModel._IMAGE_FOLDER + image))
            : {},
        super.fromJson(json);

  @override
  bool isCorrectlyAnswered() => this.userAnswer == this.correctReaction;

  @override
  bool isCorrectAnswer(String answer) => answer == this.correctReaction;

  @override
  String toString() => "${this.correctReaction} (${this.signification})";
}
