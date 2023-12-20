import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


class Db{
  Future<Database> initializeDB() async{
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'contact_list.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE contact(id INT PRIMARY KEY, email TEXT, first_name TEXT, last_name TEXT, avatar TEXT, favourite INT)',
        );
      },
      version: 1,
    );
  }
}