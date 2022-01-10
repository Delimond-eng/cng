import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database _db;
  static const String DB_NAME = 'cng.db';

  static Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();
    return _db;
  }

  static Future<Database> initDb() async {
    var dbPath = await getDatabasesPath();
    String path = join(dbPath, DB_NAME);
    Database db;
    if (db != null) {
      return db;
    }
    db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  static _onCreate(Database db, int version) async {
    try {
      await db.transaction((txn) async {
        await db.execute(
            "CREATE TABLE medecins(id INTEGER PRIMARY KEY AUTOINCREMENT, medecin_id TEXT, photo TEXT, nom TEXT, telephone TEXT, email TEXT, specialite TEXT)");
      });
    } catch (err) {
      print("error from transaction");
    }
  }
}
