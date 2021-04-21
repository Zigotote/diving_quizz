import 'dart:convert';

import 'package:diving_quizz/models/meaning.dart';

abstract class QuestionModel {
  static const String _IMAGE_FOLDER = "assets/images/signs/";

  /// The id of the database object
  final int id;

  /// The explained signification of the expected answer
  final String signification;

  /// The answers the bot proposes
  Set<String> proposedAnswers = {};

  /// The answer the user has selected
  String userAnswer;

  QuestionModel(this.id, this.signification);

  /// Creates a QuestionModel from a json object
  QuestionModel.fromJson(Map<String, dynamic> json)
      : signification = json["signification"],
        id = 0;

  /// Creates a QuestionModel from a json object comming from the database
  QuestionModel.fromDatabase(Map<String, dynamic> json)
      : signification = json["signification"],
        id = json["id"];

  /// Checks if the answer is correct
  bool isCorrectAnswer(String answer);

  /// Checks if the user has correctly answered the question
  bool isCorrectlyAnswered();

  /// Returns the answer the user should have selected
  String get expectedAnswer;
}

/// A QuestionModel to learn the meaning of a sign
class SignQuestionModel extends QuestionModel {
  /// The image the user has to know
  final String image;

  /// The different meanings of the sign, linked to their associated reactions
  final List<Meaning> meanings;

  /// The meanings which have already been asked, corresponding to the elements which have been deleted from meanings during a duplicate()
  final Set<String> deletedMeanings;

  /// The trick answer, if the sign is similar to others their meaning can be added to this Set to make the QuestionModel harder
  final Set<String> tricks;

  /// Returns the correct meanings for the question
  Set<String> get correctMeanings => meanings
      .map((element) => element.meanings)
      .expand((meaning) => meaning)
      .toSet();

  @override
  String get expectedAnswer => proposedAnswers
      .firstWhere((meaning) => correctMeanings.contains(meaning));

  SignQuestionModel(int id, this.image, String signification, this.meanings,
      this.tricks, this.deletedMeanings)
      : super(id, signification);

  @override
  SignQuestionModel.fromJson(Map<String, dynamic> json)
      : image = QuestionModel._IMAGE_FOLDER + json["image"],
        meanings = (json["meanings"] as List)
            .map((meaning) => Meaning.fromJson(meaning))
            .toList(),
        tricks = json["trickMeanings"] != null
            ? Set.from(json["trickMeanings"])
            : {},
        deletedMeanings = {},
        super.fromJson(json);

  @override
  SignQuestionModel.fromDatabase(
      Map<String, dynamic> json, List<Meaning> meanings)
      : image = json["image"],
        meanings = meanings,
        tricks = Set.from(jsonDecode(json["tricks"])),
        deletedMeanings = {},
        super.fromDatabase(json);

  /// Converts a SignQuestion to a json format
  Map<String, dynamic> toJson() => {
        "image": this.image,
        "signification": this.signification,
        "tricks": jsonEncode(this.tricks.toList()),
      };

  @override
  bool isCorrectlyAnswered() => this.correctMeanings.contains(this.userAnswer);

  @override
  bool isCorrectAnswer(String answer) =>
      this.correctMeanings.contains(answer) ||
      this.deletedMeanings.contains(answer);

  /// Returns the Meaning from the meanings list representing the meaning in parameter
  Meaning getMeaning(String meaning) {
    return this
        .meanings
        .firstWhere((element) => element.meanings.contains(meaning));
  }

  /// Creates a new SignQuestionModel without the meaning in parameter
  SignQuestionModel duplicate(String meaning) {
    Meaning toDelete = this.getMeaning(meaning);
    SignQuestionModel newQuestion = new SignQuestionModel(
      this.id,
      this.image,
      this.signification,
      List.from(this.meanings.where((element) => element != toDelete)),
      this.tricks,
      {...toDelete.meanings, ...this.deletedMeanings},
    );
    return newQuestion;
  }

  @override
  String toString() {
    String str = "${this.image} -> ${this.userAnswer} \n";
    str += "Tricks : [${this.tricks.join(",")}]\n";
    str += this.meanings.join("\n");
    str += "Proposed answers : {${this.proposedAnswers.join(",")}}";
    return str;
  }
}

/// A QuestionModel to learn the meaning of a sign and the reaction to apply to it
class ReactionQuestionModel extends QuestionModel {
  /// The expected reaction to produce after the sign
  final String correctReaction;

  /// The trick reaction, if the sign is similar to others their reactions can be added to this Set to make the QuestionModel harder
  final Set<String> tricks;

  @override
  String get expectedAnswer => correctReaction;

  ReactionQuestionModel(
      int id, String signification, this.correctReaction, this.tricks)
      : super(id, signification);

  @override
  ReactionQuestionModel.fromJson(Map<String, dynamic> json)
      : correctReaction = QuestionModel._IMAGE_FOLDER + json["image"],
        tricks = json["trickReactions"] != null
            ? Set.from(json["trickReactions"]
                .map((image) => QuestionModel._IMAGE_FOLDER + image))
            : {},
        super.fromJson(json);

  @override
  ReactionQuestionModel.fromDatabase(Map<String, dynamic> json)
      : correctReaction = json["image"],
        tricks = Set.from(jsonDecode(json["tricks"])),
        super.fromDatabase(json);

  /// Converts a ReactionQuestion to a json format with the database id of the related Meaning
  Map<String, dynamic> toJson(int idMeaning) => {
        "idMeaning": idMeaning,
        "signification": this.signification,
        "image": this.correctReaction,
        "tricks": jsonEncode(this.tricks.toList()),
      };

  @override
  bool isCorrectlyAnswered() => this.userAnswer == this.correctReaction;

  @override
  bool isCorrectAnswer(String answer) => answer == this.correctReaction;

  @override
  String toString() =>
      "${this.correctReaction} (${this.signification}) [${this.tricks.join(",")}]";
}
