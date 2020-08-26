import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:thingtranslator/models/history.dart';
import 'package:thingtranslator/models/history_url.dart';

class DatabaseHelper {
  DatabaseHelper._();

  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get getDatabase async {
    if (_database == null) {
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async {
    Directory directory = await getExternalStorageDirectory();
    String dataPath = join("${directory.path}", "data.sqlite");
    print(directory.path);
    return await openDatabase(
      dataPath,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute("CREATE TABLE History ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
            "imageFile TEXT,"
            "english TEXT,"
            "khmer TEXT,"
            "score TEXT,"
            "date TEXT"
            ")");

        await db.execute("CREATE TABLE HistoryUrl ("
            "id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,"
            "imageUrl TEXT,"
            "english TEXT,"
            "khmer TEXT,"
            "score TEXT,"
            "date TEXT"
            ")");
      },
    );
  }

  Future<void> insertIntoHistory(
      String imageFile, String english, String khmer, String score) async {
    final db = await getDatabase;

    await db.rawInsert(
        "INSERT INTO History (imageFile, english, khmer, score, date)"
        "VALUES ('$imageFile', '$english', '$khmer', '$score', datetime('now', 'localtime'))"
        "");
    print(
        "add to $imageFile, $english, $khmer, $score, datetime('now', 'localtime')");
  }

  Future<void> insertIntoHistoryUrl(
      String imageUrl, String english, String khmer, String score) async {
    final db = await getDatabase;

    await db.rawInsert(
        "INSERT INTO HistoryUrl (imageUrl, english, khmer, score, date)"
        "VALUES ('$imageUrl', '$english', '$khmer', '$score', datetime('now', 'localtime'))"
        "");
    print(
        "add to $imageUrl, $english, $khmer, $score, datetime('now', 'localtime')");
  }

  Future<List<History>> getImageFileHistoryList() async {
    final db = await getDatabase;

    final List<Map<String, dynamic>> maps = await db.rawQuery(""
        "SELECT id, imageFile, english, khmer, score, date FROM History ORDER BY date DESC");

    return List.generate(maps.length, (index) {
      return History(
        id: maps[index]['id'],
        imageFile: maps[index]['imageFile'],
        english: maps[index]['english'],
        khmer: maps[index]['khmer'],
        score: maps[index]['score'],
        date: maps[index]['date'],
      );
    });
  }

  Future<List<HistoryUrl>> getImageUrlHistoryList() async {
    final db = await getDatabase;

    final List<Map<String, dynamic>> maps = await db.rawQuery(""
        "SELECT id, imageUrl, english, khmer, score, date FROM HistoryUrl ORDER BY date DESC");

    return List.generate(maps.length, (index) {
      return HistoryUrl(
        id: maps[index]['id'],
        imageUrl: maps[index]['imageUrl'],
        english: maps[index]['english'],
        khmer: maps[index]['khmer'],
        score: maps[index]['score'],
        date: maps[index]['date'],
      );
    });
  }

  Future<void> deleteHistory(int id) async {
    final db = await getDatabase;

    await db.rawDelete("DELETE FROM History WHERE id=$id");

    print("delete id on $id");
  }

  Future<void> deleteHistoryUrl(int id) async {
    final db = await getDatabase;

    await db.rawDelete("DELETE FROM HistoryUrl WHERE id=$id");

    print("delete id on $id");
  }
}
