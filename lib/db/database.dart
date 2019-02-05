import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/model/book.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE BookShelf ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT"
          ")");
      await db.execute("CREATE TABLE Book ("
          "id INTEGER PRIMARY KEY,"
          "bookshelf_id INTEGER,"
          "name TEXT,"
          "author_name TEXT,"
          "file_path TEXT"
          ")");
      await db.rawInsert("INSERT Into BookShelf (id,name)"
          "VALUES (1,'All')");
    });
  }

  addBookshelf(BookShelf bookshelf) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Bookshelf");
    int id = table.first["id"];

    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into BookShelf (id,name)"
        " VALUES (?,?)",
        [id, bookshelf.name]);
    return raw;
  }

  Future<List<BookShelf>> getAllBookshelves() async {
    final db = await database;
    var res = await db.query("Bookshelf");
    List<BookShelf> bookshelves =
        res.isNotEmpty ? res.map((c) => BookShelf.fromMap(c)).toList() : [];

    return bookshelves;
  }
}
