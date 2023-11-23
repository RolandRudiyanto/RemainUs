import 'package:remainus/Model/notes.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user.dart';
import 'database_helper.dart';

class NoteOprational{

  Future<int> insertNotes(Notes notes) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('notes', notes.toMap());
  }

  Future<List<Notes>> getNotes() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser = await db.query('notes');
    List<Notes> note = allUser.map((note)=> Notes.formMap(note)).toList();
    return note;
  }

  Future<List<Notes>> getNotesByEmail(User user) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser = await db.query('''
    SELECT * FROM notes WHERE notes.emial = ${user.emial}
    ''');
    List<Notes> note = allUser.map((note)=> Notes.formMap(note)).toList();
    return note;
  }


}