import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'historyitem.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();
  static Database? _database;

  DatabaseHelper._instance();

  Future<Database> get db async {
    _database ??= await initDb();
    return _database!;
  }

  Future<Database> initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'userhistory.db');

    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE userhistory (
        date TEXT,
        steps INTEGER,
        goalReached INTEGER
      )
    ''');
  }

  Future<int> insertHistoryItem(HistoryItem historyitem) async {
    Database db = await instance.db;
    return await db.insert('userhistory', historyitem.toMap());
  }

  Future<List<Map<String, dynamic>>> queryAllHistoryItems() async {
    Database db = await instance.db;
    return await db.query('userhistory');
  }

  Future<int> updateHistoryItem(HistoryItem historyitem) async {
    Database db = await instance.db;
    return await db.update('userhistory', historyitem.toMap(), where: 'date = ?', whereArgs: [historyitem.date]);
  }

  Future<int> deleteHistoryItem(int id) async {
    Database db = await instance.db;
    return await db.delete('userhistory', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> initializeHistoryItems() async {
    List<HistoryItem> historyitemsToAdd = [
      HistoryItem(date: DateTime.now()),
    ];

    for (HistoryItem historyitem in historyitemsToAdd) {
      await insertHistoryItem(historyitem);
    }
  }
}