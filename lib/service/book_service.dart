import 'dart:io';
import 'package:ebook_reader/model/book.dart';
import 'package:ebook_reader/service/image_service.dart';
import 'package:epub_parser/epub_parser.dart';

import 'package:ebook_reader/util/app_util.dart';
import 'package:ebook_reader/bloc/book_bloc.dart';

class BookService {
  // Extract, Parse and Save the book into DB
  importBook(String filePath, int bookshelfId) async {
    String appDirectory = await AppUtil.localPath;
    File bookFile = new File(filePath);
    String bookAppPath = appDirectory + "/" + filePath.split("/").last;
    bookFile = await bookFile.copy(bookAppPath);
    print("Book copied to : $bookFile");

    EpubBookRef bookRef = await EpubReader.openBook(bookFile.readAsBytesSync());
    if (bookRef.coverImage == null) {
      bookRef.coverImage = ImageService.generateCoverArt(bookRef.title);
    }

    print("## Book parsed");
    bookBloc.saveBook(bookAppPath, bookRef.title, bookRef.author, bookRef.coverImage);
  }

  readBook(Book book) async {
    File bookFile = new File(book.filePath);
    EpubBook epubBook = await EpubReader.readBook(bookFile.readAsBytesSync());
    print(epubBook.content.htmlContent);
  }
}
