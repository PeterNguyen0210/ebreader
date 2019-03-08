import 'package:ebook_reader/model/book.dart';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:archive/archive_io.dart';
import 'package:ebook_reader/util/app_util.dart';
import 'package:ebook_reader/bloc/book_bloc.dart';

abstract class BookService {
  // Extract, Parse and Save the book into DB
  importBook(String filePath, int bookshelfId) async {
    String bookDirectory = await extractBook(filePath);
    print("## Book extracted to : $bookDirectory");

    Book book = await parseBookMetadata(bookDirectory, filePath, bookshelfId);
    print("## Book parsed : " + book.name);

    await bookBloc.saveBook(book);
  }

  Future<String> extractBook(String filePath) async {
    final appRootDirectory = await AppUtil.tmpPath;

    // Extracting the book folder name from filePath
    final String folderName = filePath.split("/").last.split(".")[0];

    String bookDirectory = appRootDirectory + "/" + folderName;

    // Try to Cleanup exisitng directory with same name
    try {
      var dir = new Directory(bookDirectory);
      dir.deleteSync(recursive: true);
    } on FileSystemException catch (e) {}

    // Extracting the book into a tmp folder
    List<int> bytes = new File(filePath).readAsBytesSync();
    Archive archive = new ZipDecoder().decodeBytes(bytes);
    for (ArchiveFile file in archive) {
      String filename = file.name;
      if (file.isFile) {
        List<int> data = file.content;
        new File(bookDirectory + '/' + filename)
          ..createSync(recursive: true)
          ..writeAsBytesSync(data);
      } else {
        new Directory(bookDirectory + '/' + filename)..create(recursive: true);
      }
    }
    return bookDirectory;
  }

  // Book parsing logic will be specific to the format.
  Future<Book> parseBookMetadata(
      String bookDirectory, String filePath, int bookshelfId);
}
