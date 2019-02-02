import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(EbookReader());

class EbookReader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new BookShelfViewer());
  }
}

class BookShelfViewer extends StatefulWidget {
  @override
  BookShelfViewerState createState() => new BookShelfViewerState();
}

class BookShelfViewerState extends State<BookShelfViewer> {
  var _bookshelves = <String>[];
  final _biggerFont = const TextStyle(fontSize: 18);

  @override
  void initState() {
    super.initState();
    _loadBookshelves();
  }

  void _loadBookshelves() {
    print('loading bookshelves');
    _bookshelves.add("Fiction");
    _bookshelves.add("Mystery");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BookShelves'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.settings), onPressed: _openExtraOptions)
        ],
      ),
      body: _showBookshelves(),
    );
  }

  Widget _showBookshelves() {
    print('showing bookshelves');
    if (_bookshelves.length == 0) {
      return Center(
        child: Text("No Bookshelves to show"),
      );
    }

    final Iterable<ListTile> tiles = _bookshelves.map((String bookshelf) {
      return new ListTile(
        title: new Text(
          bookshelf,
          style: _biggerFont,
        ),
        onTap: () {
          _openBookShelf(bookshelf);
        },
      );
    });

    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return new ListView(children: divided);
  }

  void _openBookShelf(String shelfName) {
    print(shelfName + " opened");
  }

  void _openExtraOptions() {}
}
