import 'package:rxdart/rxdart.dart';

import 'package:ebook_reader/model/book.dart';
import 'package:ebook_reader/db/database.dart';

class BookBloc {
  final _booksFetcher = PublishSubject<List<Book>>();

  Observable<List<Book>> get allBooksFromBookShelf => _booksFetcher.stream;

  fetchBooksByBookshelfId(int id) async {
    List<Book> books = await DBProvider.db.getBooksByBookshelfId(id);
    if (books.length == 0) {
      _booksFetcher
          .addError("No Books Found. Click on + button to add new books.");
    } else {
      _booksFetcher.sink.add(books);
    }
  }

  saveBook(Book book) async {
    var out = await DBProvider.db.addBookToShelf(book);
  }

  dispose() {
    _booksFetcher.close();
  }
}

final bookBloc = BookBloc();