import 'dart:convert';

import 'question.dart';

// A meaning for a SignQuestionModel object
class Meaning {
  /// The id of the database object
  final int id;

  /// The meaning
  final Set<String> meanings;

  /// The associated reactions for this meaning
  final List<ReactionQuestionModel> reactions;

  Meaning(this.id, this.meanings, this.reactions);

  Meaning.fromJson(Map<String, dynamic> json)
      : id = 0,
        meanings = Set.from(json["text"]),
        reactions = json["reactions"] == null
            ? []
            : (json["reactions"] as List).map((reaction) {
                reaction["trickReactions"] = json["trickReactions"];
                return ReactionQuestionModel.fromJson(reaction);
              }).toList();

  /// Converts a Meaning to a json format with the database id of the related SignQuestion
  Map<String, dynamic> toJson(int idSignQuestion) => {
        "idSignQuestion": idSignQuestion,
        "meanings": jsonEncode(this.meanings.toList()),
      };

  @override
  String toString() {
    return "{${this.meanings.join(",")}} : [${this.reactions.join(",")}] ";
  }
}
