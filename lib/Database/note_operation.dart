import 'package:remainus/Model/notes.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user.dart';
import 'database_helper.dart';

class NoteOprational{

  Future<int> insertNotes(Notes notes) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('notes', notes.toMap());
  }

  Future<int> updateTotal(Notes notes) async{
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> existingNotes = await db.query(
      'notes',
      where: 'noteId = ?',
      whereArgs: [notes.noteId],
    );
    return await db.update('notes', {'total': existingNotes[0]['total'] + notes.total}, where: 'noteId = ?', whereArgs: [notes.noteId]);
  }

  Future<int> updateUser(int? noteId, int? total) async{
    Database db = await DatabaseHelper.instance.database;
    return await db.update('notes', {'total': total}, where: 'noteId = ?', whereArgs: [noteId]);
  }

  Future<List<Notes>> getNotes() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser = await db.query('notes');
    List<Notes> note = allUser.map((note)=> Notes.formMap(note)).toList();
    return note;
  }

  Future<List<Notes>> getNotesByNotes(int? id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser =  await db.query('notes', where: 'noteId = ?', whereArgs: [id]);
    List<Notes> note = allUser.map((note)=> Notes.formMap(note)).toList();
    return note;
  }

  Future<List<Notes>> getItemByNotes(String? username) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser =  await db.query('notes', where: 'username = ?', whereArgs: [username]);
    List<Notes> note = allUser.map((note)=> Notes.formMap(note)).toList();
    return note;
  }

  Future<int> delete(int? id) async{
    Database db = await DatabaseHelper.instance.database;
    return await db!.delete('notes',where: 'noteid = ?', whereArgs: [id]);
  }

  // Future<List<Notes>> getTahun() async {
  //   Database db = await DatabaseHelper.instance.database;
  //
  //   List<Map<String, dynamic>> allUser = await db.rawQuery('''
  //   SELECT year, SUM(total) as totalAmount
  //   FROM notes
  //   GROUP BY year
  // ''');
  //
  //   List<Notes> note = [];
  //
  //   for (var map in allUser) {
  //     List<Map<String, dynamic>> yearData = await db.query(
  //       'notes',
  //       where: 'year = ?',
  //       whereArgs: [map['year']],
  //     );
  //
  //     // Add a single Notes object for the year with totalAmount
  //     note.add(Notes(
  //       year: map['year'],
  //       totalAmount: map['totalAmount'],
  //     ));
  //
  //     // Add the rest of the records for the year
  //     for (var data in yearData) {
  //       note.add(Notes.formMap(data));
  //     }
  //   }
  //
  //   return note;
  // }



}