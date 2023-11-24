import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:remainus/Database/database_helper.dart';
import 'package:remainus/Model/user.dart';

class UserOprations{

  Future<int> insertUser(User user) async {
    Database db = await DatabaseHelper.instance.database;
    return await db.insert('user', user.toMap());
  }

  Future<User?> signIn(String username, String password) async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> maps = await db.query('user',
        where: 'username = ? AND password = ?', whereArgs: [username, password]);

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    }

    return null;
  }

  Future<int> updateUser(User user) async{
    Database db = await DatabaseHelper.instance.database;
    return await db.update('user', user.toMap(), where: 'userId = ?', whereArgs: [user.userId]);
  }

  Future<List<User>> getUser() async {
    Database db = await DatabaseHelper.instance.database;
    List<Map<String, dynamic>> allUser = await db.query('user');
    List<User> users = allUser.map((user)=> User.fromMap(user)).toList();
    return users;
  }

}