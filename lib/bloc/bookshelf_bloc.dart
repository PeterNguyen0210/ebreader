import 'package:rxdart/rxdart.dart';

import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/db/database.dart';

class BookshelfBloc {
  final _bookshelvesFetcher = PublishSubject<List<BookShelf>>();

  Observable<List<BookShelf>> get allBookshelves => _bookshelvesFetcher.stream;

  fetchAllBookshelves() async {
    List<BookShelf> bookshelfList = await DBProvider.db.getAllBookshelves();
    _bookshelvesFetcher.sink.add(bookshelfList);
  }

  dispose() {
    _bookshelvesFetcher.close();
  }
}

final bloc = BookshelfBloc();
