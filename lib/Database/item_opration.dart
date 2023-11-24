import 'package:remainus/Model/belanja_item.dart';
import 'package:remainus/Model/notes.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user.dart';
import 'database_helper.dart';

class ItemOprational{

  Future<int> insertItem(Belanja item) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('item', item.toMap());
  }

  Future<List<Belanja>> getItemByNotes(Notes notes) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser = await db.query('''
    SELECT * FROM item WHERE item.noteId = ${notes.noteId}
    ''');
    List<Belanja> belanja = allUser.map((belanja)=> Belanja.formMap(belanja)).toList();
    return belanja;
  }

}