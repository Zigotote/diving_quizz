import 'dart:convert';

import 'package:diving_quizz/models/meaning.dart';
import 'package:diving_quizz/models/question.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// A provider to manage the SQLite database
class DatabaseProvider {
  /// The connection to the database
  static Database _database;

  /// The singleton instance
  static final DatabaseProvider instance = DatabaseProvider._();

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
      version: 1,
      onOpen: (Database db) async {
        await _createDbScheme(db);
        await _fillDatabase(db);
      },
    );
  }

  /// Creates the database tables
  Future _createDbScheme(Database db) async {
    await db.execute("DROP TABLE IF EXISTS SignQuestion");
    await db.execute(
      "CREATE TABLE SignQuestion (id INTEGER PRIMARY KEY AUTOINCREMENT, image TEXT, signification TEXT, tricks TEXT)",
    );
    await db.execute("DROP TABLE IF EXISTS Meaning");
    await db.execute(
      "CREATE TABLE Meaning (id INTEGER PRIMARY KEY AUTOINCREMENT, idSignQuestion INTEGER, meanings TEXT)",
    );
    await db.execute("DROP TABLE IF EXISTS ReactionQuestion");
    await db.execute(
      "CREATE TABLE ReactionQuestion (id INTEGER PRIMARY KEY AUTOINCREMENT, idMeaning INTEGER, signification TEXT, image TEXT, tricks TEXT)",
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
        await db.insert("SignQuestion", question.toJson());
    int idMeaning;
    question.meanings.forEach((meaning) async {
      idMeaning = await db.insert("Meaning", meaning.toJson(idSignQuestion));
      meaning.reactions.forEach((reaction) async {
        await db.insert("ReactionQuestion", reaction.toJson(idMeaning));
      });
    });
    return idSignQuestion;
  }

  /// Retrieves the meanings stored in the database
  Future<Set<String>> getMeanings() async {
    final Database db = await database;
    List<Map<String, Object>> res = await db.query(
      "Meaning",
      columns: ["meanings"],
    );
    return res
        .map((e) => List<String>.from(jsonDecode(e["meanings"])))
        .expand((element) => element)
        .toSet();
  }

  /// Retrieves all the SignQuestion stored in the databse
  Future<List<SignQuestionModel>> getSignQuestions() async {
    final Database db = await database;
    List<Map<String, Object>> resSignQuestions = await db.query("SignQuestion");
    List<SignQuestionModel> signQuestions = [];
    for (Map<String, Object> signQuestion in resSignQuestions) {
      List<Map<String, Object>> resMeanings = await db.query(
        "Meaning",
        where: "idSignQuestion=?",
        whereArgs: [signQuestion["id"]],
      );
      List<Meaning> meanings = [];
      for (Map<String, Object> meaning in resMeanings) {
        final List<Map<String, Object>> resReactions = await db.query(
          "ReactionQuestion",
          where: "idMeaning=?",
          whereArgs: [meaning["id"]],
        );
        List<ReactionQuestionModel> reactions = resReactions
            .map((reaction) => ReactionQuestionModel.fromDatabase(reaction))
            .toList();
        meanings
            .add(Meaning(Set.from(jsonDecode(meaning["meanings"])), reactions));
      }
      signQuestions.add(SignQuestionModel.fromDatabase(signQuestion, meanings));
    }
    return signQuestions;
  }
}
