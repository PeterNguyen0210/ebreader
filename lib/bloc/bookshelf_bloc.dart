import 'package:rxdart/rxdart.dart';

import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/model/book.dart';
import 'package:ebook_reader/db/database.dart';

class BookshelfBloc {
  final _bookshelvesFetcher = PublishSubject<List<BookShelf>>();
  final _booksFetcher = PublishSubject<List<Book>>();

  Observable<List<BookShelf>> get allBookshelves => _bookshelvesFetcher.stream;
  Observable<List<Book>> get allBooksFromBookShelf => _booksFetcher.stream;

  fetchAllBookshelves() async {
    List<BookShelf> bookshelfList = await DBProvider.db.getAllBookshelves();
    _bookshelvesFetcher.sink.add(bookshelfList);
  }

  fetchBooksByBookshelfId(int id) async {
    List<Book> books = await DBProvider.db.getBooksByBookshelfId(id);
    if (books.length == 0) {
      _booksFetcher
          .addError("No Books Found. Click on + button to add new books.");
    } else {
      _booksFetcher.sink.add(books);
    }
  }

  addBookshelf(String name) async {
    var out = await DBProvider.db.addBookshelf(name);
    print("Bloc" + out.toString());
  }

  addBook(int bookshelfId, String bookName) async {
    var out = await DBProvider.db.addBookToShelf(bookshelfId, bookName);
  }

  dispose() {
    _bookshelvesFetcher.close();
    _booksFetcher.close();
  }
}

final bloc = BookshelfBloc();
