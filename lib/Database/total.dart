import 'package:remainus/Model/belanja_item.dart';
import 'package:remainus/Model/notes.dart';
import 'package:remainus/Model/total.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user.dart';
import 'database_helper.dart';

class TotalOprational{

  Future<int> insertTotal(Total total) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('total', total.toMap());
  }

  Future<List<Total>> getItemByNotes(Notes notes) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser = await db.query('''
    SELECT * FROM total WHERE total.noteId = ${notes.noteId}
    ''');
    List<Total> total = allUser.map((total)=> Total.formMap(total)).toList();
    return total;
  }

}