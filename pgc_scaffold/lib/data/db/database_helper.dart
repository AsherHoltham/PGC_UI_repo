//*** SQFLITE DATABASE HELPER ***//
import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Singleton instance
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static Database? _database;

  // Provide a getter for the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the necessary tables
  FutureOr<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE your_model(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        description TEXT
      )
    ''');
  }

  // Example CRUD method: Insert a new model record
  Future<int> insertModel(Map<String, dynamic> row) async {
    Database db = await database;
    return await db.insert('your_model', row);
  }

  // Example CRUD method: Query all model records
  Future<List<Map<String, dynamic>>> queryAllModels() async {
    Database db = await database;
    return await db.query('your_model');
  }
}
