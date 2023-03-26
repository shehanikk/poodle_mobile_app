import 'package:sqflite/sqflite.dart';

import '../model/task.dart';

class DBHelper{
  static Database? _db;
  static final int _version = 1;
  static final String _tableName = "tasks";

  static Future<void> initDb() async{
    if (_db != null) {
      return;
    }
    try {
      String _path = await getDatabasesPath() + 'tasks.db';
      _db = await openDatabase(
        _path,
        version: _version,
        onCreate: (db, version) {
          print("creating a new one");
          return db.execute(
            "CREATE TABLE tasks(id INTEGER PRIMARY KEY AUTOINCREMENT, title STRING, note TEXT , date STRING,remind INTEGER, repeat STRING,color INTEGER, startTime STRING, isCompleted INTEGER,endTime STRING)",
          );
        },
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<int> insert(Task? task) async{
    print("insert fuction called");
    return await _db?.insert(_tableName, task!.toJson())??1;
  }

}