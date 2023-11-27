import 'package:remainus/Model/belanja_item.dart';
import 'package:remainus/Model/notes.dart';
import 'package:remainus/Model/total.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user.dart';
import 'database_helper.dart';

class TotalOperation{

  Future<void> updateOrInsertNotes(Total total) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> existingNotes = await db.query(
      'total',
      where: 'year = ?',
      whereArgs: [total.year],
    );

    if (existingNotes.isNotEmpty) {
      await db.update(
        'total',
        {'totalAmount': existingNotes[0]['totalAmount'] + total.totalAmount},
        where: 'year = ?',
        whereArgs: [total.year],
      );
    } else {

      await db.insert(
        'total',
        total.toMap(), // Assuming you have a toMap method in your Notes class
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Total>> getTotal() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser = await db.query('total');
    List<Total> total = allUser.map((total)=> Total.formMap(total)).toList();
    return total;
  }

  Future<List<Total>> getTotalByNotes(int? Id) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser =  await db.query('total', where: 'userId = ?', whereArgs: [Id]);
    List<Total> total = allUser.map((total)=> Total.formMap(total)).toList();
    return total;
  }

// Future<int> insertTotal(Total total) async {
  //   Database db = await DatabaseHelper.instance.database;
  //   return await db.insert('total',);
  // }
  //
  // Future<int> updateUser(String? year, int? total) async{
  //   Database db = await DatabaseHelper.instance.database;
  //   return await db.update('notes', {'total': total}, where: 'year = ?', whereArgs: [noteId]);
  // }

  // Future<List<Total>> getItemByNotes(Notes notes) async {
  //   Database db = await DatabaseHelper.instance.database;
  //   List<Map<String, dynamic>> allUser = await db.query('''
  //   SELECT * FROM total WHERE total.noteId = ${notes.noteId}
  //   ''');
  //   List<Total> total = allUser.map((total)=> Total.formMap(total)).toList();
  //   return total;
  // }

  // Future<List<Total>> getTotalByNotes(int? noteId) async {
  //   Database db = await DatabaseHelper.instance.database;
  //   List<Map<String, dynamic>> allUser =  await db.query('total', where: 'noteId = ?', whereArgs: [noteId]);
  //   List<Total> total = allUser.map((total)=> Total.formMap(total)).toList();
  //   return total;
  // }

}