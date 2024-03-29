import 'dart:async';
import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';

import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/model/book.dart';
import "package:ebook_reader/util/app_util.dart";

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
          "id TEXT PRIMARY KEY,"
          "title TEXT,"
          "author_name TEXT,"
          "file_path TEXT,"
          "cover_art BLOB"
          ")");
    });
  }

  addBookshelf(String name) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Bookshelf");
    int id = table.first["id"];

    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into BookShelf (id,name)"
        " VALUES (?,?)",
        [id, name]);
    return raw;
  }

  addBookToShelf(Book book) async {
    final db = await database;
    String id = AppUtil.generateUniqueIdForBook(book.filePath);

    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Book (id,title,author_name,file_path,cover_art)"
        " VALUES (?,?,?,?,?)",
        [id, book.title, book.authorName, book.filePath, book.coverArt]);
    return raw;
  }

  deleteBookshelf(int id) async {
    //final db = await database;
  }

  Future<List<BookShelf>> getAllBookshelves() async {
    final db = await database;
    var res = await db.query("Bookshelf");
    List<BookShelf> bookshelves =
        res.isNotEmpty ? res.map((c) => BookShelf.fromMap(c)).toList() : [];

    return bookshelves;
  }

  Future<List<Book>> getBooksByBookshelfId(int id) async {
    final db = await database;
    var res = await db.rawQuery("SELECT * FROM Book");
    List<Book> books = res.isNotEmpty ? res.map((c) => Book.fromMap(c)).toList() : [];

    return books;
  }

  deleteAllBooks() async {
    final db = await database;
    await db.rawQuery("DELETE FROM Book");
  }
}
