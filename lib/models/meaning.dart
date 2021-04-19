import 'package:diving_quizz/models/question.dart';

// A meaning for a SignQuestionModel object
class Meaning {
  /// The meaning
  final Set<String> meanings;

  /// The associated reactions for this meaning
  final List<ReactionQuestionModel> reactions;

  Meaning(this.meanings, this.reactions);

  Meaning.fromJson(Map<String, dynamic> json)
      : meanings = Set.from(json["text"]),
        reactions = json["reactions"] == null
            ? []
            : (json["reactions"] as List)
                .map((reaction) => ReactionQuestionModel.fromJson(reaction))
                .toList();

  @override
  String toString() {
    return "{${this.meanings.join(",")}} : [${this.reactions.join(",")}] ";
  }
}
