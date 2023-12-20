import 'package:flutter/material.dart';
import 'package:flutter_assessment/database/db.dart';
import 'package:flutter_assessment/model/contact.dart';
import 'package:sqflite/sqflite.dart';

class ContactData with ChangeNotifier {
  final database = Db();

  Future<void> initializeContact(List<dynamic> contact) async {
    final db = await database.initializeDB();
    for (Map<String, dynamic> element in contact) {
      final data = Contact(
        id: element["id"],
        email: element["email"],
        first_name: element["first_name"],
        last_name: element["last_name"],
        avatar: element["avatar"],
        favourite: 0,
      );
      await db.insert(
        'contact',
        data.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    notifyListeners();
  }

  Future<void> insertContact(Contact contact) async {
    final db = await database.initializeDB();
    await db.insert(
      'contact',
      contact.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<Contact>> contactList() async {
    final db = await database.initializeDB();
    final List<Map<String, dynamic>> maps = await db.query('contact');
    return List.generate(maps.length, (index) {
      return Contact(
        id: maps[index]["id"],
        email: maps[index]["email"],
        first_name: maps[index]["first_name"],
        last_name: maps[index]["last_name"],
        avatar: maps[index]["avatar"],
        favourite: maps[index]["favourite"]
      );
    });
  }

  Future<List<Contact>> favContactList() async {
    final db = await database.initializeDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'contact',
      where: 'favourite = ?',
      whereArgs: [1],
    );
    return List.generate(maps.length, (index) {
      return Contact(
        id: maps[index]["id"],
        email: maps[index]["email"],
        first_name: maps[index]["first_name"],
        last_name: maps[index]["last_name"],
        avatar: maps[index]["avatar"],
          favourite: maps[index]["favourite"]
      );
    });
  }

  Future<void> deleteContact(int id) async {
    final db = await database.initializeDB();
    await db.delete(
      'contact',
      where: 'id = ?',
      whereArgs: [id],
    );
    notifyListeners();
  }

  Future<void> updateContact(Contact contact) async {
    final db = await database.initializeDB();
    await db.update(
      'contact',
      contact.toMap(),
      where: 'id = ?',
      whereArgs: [contact.id],
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    notifyListeners();
  }

  Future<List<Contact>> searchContact(String query) async{
    List<Contact> maps = [];
    final List<Contact> contact = await contactList();
    for (var element in contact) {
      if(element.first_name.toLowerCase().contains(query.toLowerCase()) && query != ""){
        maps.add(element);
      }
    }
    return List.generate(maps.length, (index) {
      return Contact(
          id: maps[index].id,
          email: maps[index].email,
          first_name: maps[index].first_name,
          last_name: maps[index].last_name,
          avatar: maps[index].avatar,
          favourite: maps[index].favourite
      );
    });
  }

}
