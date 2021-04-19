import 'package:diving_quizz/models/question.dart';

// A meaning for a SignQuestionModel object
class Meaning {
  /// The meaning
  final String meaning;

  /// The associated reactions for this meaning
  final List<ReactionQuestionModel> reactions;

  Meaning(this.meaning, this.reactions);

  Meaning.fromJson(Map<String, dynamic> json)
      : meaning = json["text"],
        reactions = json["reactions"] == null
            ? []
            : (json["reactions"] as List)
                .map((reaction) => ReactionQuestionModel.fromJson(reaction))
                .toList();

  @override
  String toString() {
    return "{${this.meaning}} : [${this.reactions.join(",")}] ";
  }
}
