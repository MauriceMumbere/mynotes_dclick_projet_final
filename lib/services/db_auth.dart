import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class DBAuth {
  static Database? _db;
  static const String tableUsers = "users";

  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "auth.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $tableUsers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            email TEXT UNIQUE NOT NULL,
            password TEXT NOT NULL
          )
        ''');
      },
    );
  }

  static Future<int> register(String email, String password) async {
    final db = await database;

    final existingUser = await db.query(
      tableUsers,
      where: "email = ?",
      whereArgs: [email],
    );

    if (existingUser.isNotEmpty) {
      return 0;
    } else {
      final id = await db.insert(tableUsers, {
        "email": email,
        "password": password,
      }, conflictAlgorithm: ConflictAlgorithm.abort);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUserEmail', email);

      return id;
    }
  }

  static Future<Map<String, dynamic>?> login(
    String email,
    String password,
  ) async {
    final db = await database;
    final res = await db.query(
      tableUsers,
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );

    if (res.isNotEmpty) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('currentUserEmail', email);

      return res.first;
    }
    return null;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    await prefs.remove('currentUserEmail');
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  static Future<String?> currentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('currentUserEmail');
  }
}
