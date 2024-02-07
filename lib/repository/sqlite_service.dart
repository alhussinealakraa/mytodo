import 'package:my_todo/core/feature/model/params/todo_filter_params.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../core/feature/model/response/todo_model.dart';

class SQLiteService {
  static final SQLiteService _instance = SQLiteService._();

  factory SQLiteService() => _instance;

  SQLiteService._() {
    initializeDB();
  }

  static Database? _database;

  Future<Database> get database async {
    _database ??= await initializeDB();
    return _database!;
  }
  Future<Database> initializeDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'myTodo.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE TODO (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        TITLE TEXT,
        DESCRIPTION TEXT,
        DATE TEXT,
        ISCOMPLETED INTEGER
      )
    ''');
  }

  Future<int> addTodo(TodoModel todoModel) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.insert(
        'TODO',
        todoModel.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    });
  }

  Future<List<TodoModel>> getAllTodos(ToDoFilterParams params) async {
    final db = await database;
    List<Map<String, dynamic>> maps = [];
    if (params.onlyNotCompleted) {
      maps = await db.query(
          'TODO',
          orderBy: "id DESC",
          where: 'ISCOMPLETED = ?',
          whereArgs: [0]
      );
    } else {
      maps = await db.query(
          'TODO',
          orderBy: "id DESC",
      );
    }
    return List.generate(
      maps.length,
          (index) {
        return TodoModel.fromJson(maps[index]);
      },
    );
  }

  Future<int> updateTodo(TodoModel todoModel) async {
    final db = await database;
    return db.transaction((txn) async {
      return await txn.update(
        'TODO',
        todoModel.toJson(),
        where: 'id = ?',
        whereArgs: [todoModel.id],
      );
    });
  }

  Future<int> deleteTodo(TodoModel todoModel) async {
    final db = await database;
    return db.transaction(
          (txn) async {
        return await txn.delete(
          'TODO',
          where: 'id = ?',
          whereArgs: [todoModel.id],
        );
      },
    );
  }


}