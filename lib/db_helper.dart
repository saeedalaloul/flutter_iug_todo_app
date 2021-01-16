import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todoapp/task_model.dart';

class DBHelper {
  DBHelper._();
  static DBHelper dbHelper = DBHelper._();
  static final String databaseName = 'tasksDB.db';
  static final String tableName = 'tasks';
  static final String taskIdColumnName = 'id';
  static final String taskNameColumnName = 'taskName';
  static final String taskIsCompleteColumnName = 'isComplete';
  Database database;
  Future<Database> initDatabase() async {
    if (database == null) {
      return database = await createDataBase();
    } else {
      return database;
    }
  }

  Future<Database> createDataBase() async {
    try {
      var databasesPath = await getDatabasesPath();
      String path = join(databasesPath, databaseName);
      Database database = await openDatabase(path, version: 1,
          onCreate: (Database db, int version) async {
        // When creating the db, create the table
        await db.execute('''CREATE TABLE $tableName(
              $taskIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT,
              $taskNameColumnName TEXT NOT NULL,
              $taskIsCompleteColumnName INTEGER)''');
      });
      return database;
    } on Exception catch (e) {
      print(e);
    }
  }

  insertNewTask(Task task) async {
    try {
      database = await initDatabase();
      int result = await database.insert(tableName, task.toJson());
      print(result);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> fetchAllTasks() async {
    try {
      database = await initDatabase();
      List<Map> tasks = await database.query(tableName);
      return tasks.length == 0
          ? []
          : tasks.map((e) => Task.fromMapObject(e)).toList();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<List<Task>> fetchSpecificTask(bool isComplete) async {
    try {
      database = await initDatabase();
      List<Map> tasks = await database.query(tableName,
          where: '$taskIsCompleteColumnName=?',
          whereArgs: [isComplete ? 1 : 0]);
      return tasks.length == 0
          ? []
          : tasks.map((e) => Task.fromMapObject(e)).toList();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<int> updateTask(Task task) async {
    try {
      database = await initDatabase();
      return await database.update(tableName, task.toJson(),
          where: '$taskIdColumnName=?', whereArgs: [task.id]);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<int> deleteTask(int id) async {
    try {
      database = await initDatabase();
      return await database
          .delete(tableName, where: '$taskIdColumnName=?', whereArgs: [id]);
    } on Exception catch (e) {
      print(e);
    }
  }

  Future close() async {
    database.close();
  }
}
