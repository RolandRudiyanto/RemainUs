import 'package:remainus/Model/belanja_item.dart';
import 'package:remainus/Model/notes.dart';
import 'package:sqflite/sqflite.dart';

import '../Model/user.dart';
import 'database_helper.dart';

class ItemOprational{

  Future<void> insertOrUpdateItem(Belanja item) async {
    Database db = await DatabaseHelper.instance.database;
    final List<Map<String, dynamic>> existingItems = await db.query(
      'item',
      where: 'name = ? AND noteId = ?',
      whereArgs: [item.name, item.noteId],
    );

    if (existingItems.isNotEmpty) {
      // Item already exists, update quantity
      await db.update(
        'item',
        {'quantity': existingItems[0]['quantity'] + 1},
        where: 'name = ? AND noteId = ?',
        whereArgs: [item.name, item.noteId],
      );
    } else {
      // Item doesn't exist, insert new item
      await db.insert(
        'item',
        item.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }

  Future<List<Belanja>> getItemByNotes(int? noteId) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser =  await db.query('item', where: 'noteId = ?', whereArgs: [noteId]);
    List<Belanja> belanja = allUser.map((belanja)=> Belanja.formMap(belanja)).toList();
    return belanja;
  }

  Future<List<Belanja>> getItem() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allItem = await db.query('item');
    List<Belanja> item = allItem.map((item)=> Belanja.formMap(item)).toList();
    return item;
  }

  // Future<List<Map<String, dynamic>>> getJoinedData() async {
  //   Database db = await DatabaseHelper.instance.database;
  //   return db.rawQuery('''
  //     SELECT *
  //     FROM item
  //     INNER JOIN item ON item.noteId = notes.noteId
  //   ''');
  // }


// Future<int> updateItem(Belanja item) async{
  //   Database db = await DatabaseHelper.instance.database;
  //   return await db.update('item', item.toMap(), where: 'belanjaId = ?', whereArgs: [item.belanjaId]);
  // }
  //
  // Future<bool> isItemExists(Belanja item) async {
  //   Database db = await DatabaseHelper.instance.database;
  //     List<Map<String, dynamic>> result = await db.query(
  //       'item',
  //       where: 'belanjaId = ? AND name = ?',
  //       whereArgs: [item.belanjaId, item.name],
  //     );
  //     return result.isNotEmpty;
  //
  // }


}