import 'package:placement_daily_task/Placement_day_3/model/model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class DatabaseHelper {
  static final _databaseName = "user_database.db";
  static final _databaseVersion = 1;

  static final table = "users";

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        id INTEGER PRIMARY KEY,
        email TEXT NOT NULL,
        password TEXT,
        name TEXT NOT NULL,
        role TEXT,
        avatar TEXT,
        creationAt TEXT,
        updatedAt TEXT
      )
    ''');
  }

  Future<void> insertUser(Usermodel user) async {
    final db = await database;
    await db.insert(table, user.toJson());
  }

  Future<List<Usermodel>> fetchAllUsers() async {
    final db = await database;
    final result = await db.query(table);
    return result.map((json) => Usermodel.fromJson(json)).toList();
  }

  Future<void> updateUser(Usermodel user) async {
    final db = await database;
    await db.update(table, user.toJson(), where: "id = ?", whereArgs: [user.id]);
  }

  Future<void> deleteUser(int id) async {
    final db = await database;
    await db.delete(table, where: "id = ?", whereArgs: [id]);
  }

  Future<void> deleteAllUsers() async {
    final db = await database;
    await db.delete(table);
  }
}
