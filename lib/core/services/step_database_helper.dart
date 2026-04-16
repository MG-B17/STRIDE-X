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
    final path = join(dbPath, 'STRIDE_X.db');

    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (strideXDB) {},
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
        await db.execute('''
          CREATE TABLE user_data(
            id INTEGER PRIMARY KEY,
            height REAL,
            weight REAL,
            gender TEXT,
            strideLengthCm REAL,
            stepGoal INTEGER 
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        // if (oldVersion < 2) {
        //   await db.execute(
        //     'ALTER TABLE steps ADD COLUMN calories REAL DEFAULT 0.0',
        //   );
        //   await db.execute(
        //     'ALTER TABLE steps ADD COLUMN distance REAL DEFAULT 0.0',
        //   );
        // }
        // if (oldVersion < 3) {
        //   await db.execute(
        //     'ALTER TABLE steps ADD COLUMN active_time_seconds INTEGER DEFAULT 0',
        //   );
        // }
        // if (oldVersion < 4) {
        //   await db.execute('''
        //     CREATE TABLE user_data(
        //       id INTEGER PRIMARY KEY,
        //       height REAL,
        //       weight REAL,
        //       gender TEXT,
        //       stepGoal INTEGER
        //       strideLengthCm REAL
        //     )
        //   ''');
        // }
        // if (oldVersion < 5 && oldVersion >= 4) {
        //   // If already on 4 (from previous broken build), we need to add the column.
        //   // Version 3 users also get it from the onCreate if they start fresh,
        //   // but if they were on 4, they already had the table but without the column.
        //   await db.execute(
        //     'ALTER TABLE user_data ADD COLUMN strideLengthCm REAL DEFAULT 0.0',
        //   );
        // }
        // if (oldVersion < 6) {
        //   await db.execute(
        //     'ALTER TABLE user_data ADD COLUMN stepGoal INTEGER DEFAULT 2000',
        //   );
        // }
      },
    );
  }

  Future<void> saveUserData(
    double height,
    double weight,
    String gender,
    double strideLengthCm,
    int stepGoal,
  ) async {
    final db = await database;
    await db.insert('user_data', {
      'id': 1,
      'height': height,
      'weight': weight,
      'gender': gender,
      'strideLengthCm': strideLengthCm,
      'stepGoal': stepGoal,
    }, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Map<String, dynamic>?> getUserData() async {
    final db = await database;
    final List<Map<String, dynamic>> results = await db.query(
      'user_data',
      where: 'id = ?',
      whereArgs: [1],
    );
    if (results.isNotEmpty) {
      return results.first;
    }
    return null;
  }

  @override
  Future<int> insert(String table, Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert(
      table,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<Map<String, dynamic>>> query(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
    String? orderBy,
    int? limit,
  }) async {
    final db = await database;
    return await db.query(
      table,
      where: where,
      whereArgs: whereArgs,
      orderBy: orderBy,
      limit: limit,
    );
  }

  @override
  Future<int> update(
    String table,
    Map<String, dynamic> data, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.update(table, data, where: where, whereArgs: whereArgs);
  }

  @override
  Future<int> delete(
    String table, {
    String? where,
    List<dynamic>? whereArgs,
  }) async {
    final db = await database;
    return await db.delete(table, where: where, whereArgs: whereArgs);
  }

  @override
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}



