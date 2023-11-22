import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static const _databaseName = 'RemaindUs.db';
  static const _databaseVersion = 1;

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _db;

  Future<Database> get database async{
    if(_db != null) return _db!;
    _db = await _initDatabase();
    return _db!;
  }

  _initDatabase() async{
    Directory dataDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(dataDirectory.path, _databaseName);
    // print(dbPath);
    return await openDatabase(dbPath, version: _databaseVersion, onCreate: await _onCreateDB);
  }

  Future _onCreateDB(Database db, int version) async{
    await db.execute('''
      CREATE TABLE user(
        userId INTEGER PRIMARY KEY AUTOINCREMENT,
        email TEXT NOT NULL,
        password TEXT NOT NULL,
        username TEXT 
      )
''');
  }

}

