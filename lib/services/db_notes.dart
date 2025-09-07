import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/notes.dart';

class DBNotes {
  static Database? _db;

  // Nom de la table
  static const String tableNotes = "notes";

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "notes.db");

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
           CREATE TABLE $tableNotes (
           id INTEGER PRIMARY KEY AUTOINCREMENT,
           title TEXT NOT NULL,
           content TEXT NOT NULL
           )
        ''');
      },
    );
  }

  // CRUD
  static Future<int> insertNotes(Notes notes) async {
    final db = await database;
    return await db.insert(tableNotes, notes.toMap());
  }

  static Future<List<Notes>> getNotes() async {
    final db = await database;
    final maps = await db.query(tableNotes);
    return maps.map((map) => Notes.fromMap(map)).toList();
  }

  static Future<int> updateNotes(Notes notes) async {
    final db = await database;
    return await db.update(
      tableNotes,
      notes.toMap(),
      where: "id = ?",
      whereArgs: [notes.id],
    );
  }

  static Future<int> deleteNotes(int id) async {
    final db = await database;
    return await db.delete(tableNotes, where: "id = ?", whereArgs: [id]);
  }
}
