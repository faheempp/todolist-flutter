import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Data/todolistclass.dart';

class DBProvider {

  static final DBProvider db = DBProvider._init();
  DBProvider._init();
  static Database? _database;
  int taskid=0;
  static final String tableName="TaskTable";
  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    }

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }
  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {
    }, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE $tableName ("
          "id INTEGER PRIMARY KEY,"
          "title TEXT,"
          "description TEXT,"
          "done INT"
          ")");
    });
  }

 Future newTodoTask(TodoEntry entry) async {
    final db = await database;
    var res = await db!.insert(tableName, entry.toMap());
    return res;
  }

Future<List<TodoEntry>>  getTodoEntries() async {
    final db = await database;
    var json = await db!.query(tableName, orderBy: "done" + " ASC");
    List<TodoEntry> list = json.isNotEmpty ?
                               json.map((c) => TodoEntry.fromMap(c)).toList()
                               : [];
    return list;
  }
 Future getTaskWithId(int id) async {
    final db = await database;
    var json=await  db!.query(tableName, where: "id = ?", whereArgs: [id]);
    return json.isNotEmpty ? TodoEntry.fromMap(json.first) : Null ;
  }
  Future updateTodoEntry(TodoEntry entry) async{
    final db = await database;
    var res= await db!.update(tableName, entry.toMap(),where: 'id=?',whereArgs: [entry.id]);
    return res;
  }
  deleteTodoEntry(int? id) async{
    final db= await database;
    db!.delete(tableName,where: "id=?",whereArgs: [id]);
  }

  deleteAll() async{
    final db= await database;
    db!.rawDelete("Delete * from $tableName");
  }
}