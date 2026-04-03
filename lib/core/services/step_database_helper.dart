import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stridex/core/services/database_service.dart';

class StepDatabaseHelper implements DatabaseService {
  static final StepDatabaseHelper _instance = StepDatabaseHelper._internal();
  factory StepDatabaseHelper() => _instance;
  StepDatabaseHelper._internal();

  static Database? _database;

  @override
  Future<Database> get database async {
    if (_database != null) return _database!;
    await initDatabase();
    return _database!;
  }

  @override
  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'stridex.db');

    _database = await openDatabase(
      path,
      version: 3,
      onOpen: (strideXDB){
      },
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE steps(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            steps_count INTEGER,
            goal_reached_percentage REAL,
            calories REAL DEFAULT 0.0,
            distance REAL DEFAULT 0.0,
            active_time_seconds INTEGER DEFAULT 0,
            date TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('ALTER TABLE steps ADD COLUMN calories REAL DEFAULT 0.0');
          await db.execute('ALTER TABLE steps ADD COLUMN distance REAL DEFAULT 0.0');
        }
        if (oldVersion < 3) {
          await db.execute('ALTER TABLE steps ADD COLUMN active_time_seconds INTEGER DEFAULT 0');
        }
      },
    );
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  @override
  Future<List<Map<String, dynamic>>> query(String table, {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.query(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<int> update(String table, Map<String, dynamic> data, {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  @override
  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs}) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
