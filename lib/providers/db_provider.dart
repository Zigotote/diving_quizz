import 'dart:convert';

import 'package:diving_quizz/models/meaning.dart';
import 'package:diving_quizz/models/question.dart';
import 'package:diving_quizz/providers/question_pool.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A provider to manage the SQLite database
class DatabaseProvider {
  /// The connection to the database
  static Database _database;

  /// The singleton instance
  static final DatabaseProvider instance = DatabaseProvider._();

  /// The name of table where the SignQuestion are saved
  static const String TABLE_SIGNQUESTION = "SignQuestion";

  /// The name of table where the ReactionQuestion are saved
  static const String TABLE_REACTIONQUESTION = "ReactionQuestion";

  /// The name of table where the Meaning are saved
  static const String TABLE_MEANING = "Meaning";

  /// Singleton constructor
  DatabaseProvider._();

  /// Singleton for the database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  /// Initializes the database instance
  Future<Database> initDB() async {
    final String path = join(await getDatabasesPath(), "questions.db");
    return await openDatabase(
      path,
      version: 10,
      onCreate: (Database db, int version) async {
        await _createDbScheme(db);
      },
      onUpgrade: (Database db, int oldVersion, int newVersion) async {
        await _createDbScheme(db);
        await _fillDatabase(db);
      },
    );
  }

  /// Closes the connection, used in order not to lose data if incorrectly exited
  Future<void> close() async {
    final Database db = await database;
    db.close();
    _database = null;
  }

  /// Creates the database tables
  Future _createDbScheme(Database db) async {
    await db.execute("DROP TABLE IF EXISTS $TABLE_SIGNQUESTION");
    await db.execute(
      "CREATE TABLE $TABLE_SIGNQUESTION (id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, signification TEXT, tricks TEXT, nbTry INTEGER DEFAULT 0, nbFail INTEGER DEFAULT 0)",
    );
    await db.execute("DROP TABLE IF EXISTS $TABLE_MEANING");
    await db.execute(
      "CREATE TABLE $TABLE_MEANING (id INTEGER PRIMARY KEY AUTOINCREMENT, idSignQuestion INTEGER, meanings TEXT)",
    );
    await db.execute("DROP TABLE IF EXISTS $TABLE_REACTIONQUESTION");
    await db.execute(
      "CREATE TABLE $TABLE_REACTIONQUESTION (id INTEGER PRIMARY KEY AUTOINCREMENT, idMeaning INTEGER, signification TEXT, image TEXT, tricks TEXT, nbTry INTEGER DEFAULT 0, nbFail INTEGER DEFAULT 0)",
    );
  }

  /// Fills the database with the questions from the json file
  Future _fillDatabase(Database db) async {
    final String response =
        await rootBundle.loadString("assets/data/questions.json");
    final dynamic data = await json.decode(response);
    for (dynamic question in (data["questions"] as List)) {
      SignQuestionModel q = SignQuestionModel.fromJson(question);
      await _createSignQuestion(db, q);
    }
  }

  /// Saves a SignQuestion in the database
  Future<int> _createSignQuestion(
      Database db, SignQuestionModel question) async {
    final int idSignQuestion =
        await db.insert(TABLE_SIGNQUESTION, question.toJson());
    int idMeaning;
    question.meanings.forEach((meaning) async {
      idMeaning =
          await db.insert(TABLE_MEANING, meaning.toJson(idSignQuestion));
      meaning.reactions.forEach((reaction) async {
        await db.insert(TABLE_REACTIONQUESTION, reaction.toJson(idMeaning));
      });
    });
    return idSignQuestion;
  }

  /// Retrieves the meanings stored in the database
  Future<Set<String>> getMeanings() async {
    final Database db = await database;
    List<Map<String, Object>> res = await db.query(
      TABLE_MEANING,
      columns: ["meanings"],
    );
    return res
        .map((e) => List<String>.from(jsonDecode(e["meanings"])))
        .expand((element) => element)
        .toSet();
  }

  /// Retrieves all the ids of the SignQuestion stored in the databse linked to their failure rate
  Future<Map<int, int>> getSignQuestionIds() async {
    final Database db = await database;
    List<Map<String, Object>> res =
        await db.query(TABLE_SIGNQUESTION, columns: ["id", "nbTry", "nbFail"]);
    return Map.fromIterables(
      res.map<int>((e) => e["id"]),
      res.map<int>((e) {
        if (e["nbTry"] == 0) {
          return 100;
        }
        return ((e["nbFail"] as int) / (e["nbTry"] as int) * 100).round();
      }),
    );
  }

  /// Retrieves all the ids of the Meaning stored in the databse
  Future<List<int>> getMeaningIds() async {
    final Database db = await database;
    List<Map<String, Object>> res =
        await db.query(TABLE_MEANING, columns: ["id"]);
    return res.map<int>((e) => e["id"]).toList();
  }

  /// Retrieves the SignQuestion with the corresponding id
  Future<SignQuestionModel> getSignQuestion(int id) async {
    final Database db = await database;
    List<Map<String, Object>> resSignQuestion =
        await db.query(TABLE_SIGNQUESTION, where: "id=?", whereArgs: [id]);
    List<Map<String, Object>> resMeanings = await db.query(
      TABLE_MEANING,
      where: "idSignQuestion=?",
      whereArgs: [id],
    );
    List<Meaning> meanings = [];
    for (Map<String, Object> meaning in resMeanings) {
      final List<Map<String, Object>> resReactions = await db.query(
        TABLE_REACTIONQUESTION,
        where: "idMeaning=?",
        whereArgs: [meaning["id"]],
      );
      List<ReactionQuestionModel> reactions = resReactions
          .map((reaction) => ReactionQuestionModel.fromDatabase(reaction))
          .toList();
      meanings.add(Meaning(
          meaning["id"], Set.from(jsonDecode(meaning["meanings"])), reactions));
    }
    return SignQuestionModel.fromDatabase(resSignQuestion.first, meanings);
  }

  /// Updates the question saved in the table
  Future<void> updateQuestion(QuestionModel question, String table) async {
    final Database db = await database;
    await db.update(table, question.toJson(QuestionPool.lastMeaningId),
        where: "id=?", whereArgs: [question.id]);
  }
}
