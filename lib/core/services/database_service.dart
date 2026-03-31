import 'package:sqflite/sqflite.dart';

abstract class DatabaseService {
  Future<Database> get database;

  Future<void> initDatabase();

  Future<int> insert(String table, Map<String, dynamic> data);

  Future<List<Map<String, dynamic>>> query(String table, {String? where, List<dynamic>? whereArgs});

  Future<int> update(String table, Map<String, dynamic> data, {String? where, List<dynamic>? whereArgs});

  Future<int> delete(String table, {String? where, List<dynamic>? whereArgs});

  Future<void> close();
}
