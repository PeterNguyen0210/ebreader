import 'package:flutter/material.dart';

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
    //_bookshelves.add("Fiction");
    //_bookshelves.add("Mystery");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EBReader'),
        actions: <Widget>[
          new IconButton(
              icon: const Icon(Icons.settings), onPressed: _openExtraOptions)
        ],
      ),
      body: _generateBookshelvesScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showCreateBookshelfOverlay(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void showCreateBookshelfOverlay(BuildContext context) {
    print('Create Bookshelf');
    OverlayState overlayState = Overlay.of(context);
    OverlayEntry entry = OverlayEntry(
        builder: (context) => Container(
            decoration:
                new BoxDecoration(color: Color.fromARGB(150, 100, 100, 100)),
            padding: EdgeInsets.fromLTRB(
                50,
                MediaQuery.of(context).size.height * 0.4,
                50,
                MediaQuery.of(context).size.height * 0.4),
            child: Card(
              child: Row(
                children: <Widget>[
                  Text(
                    'Create Bookshelf',
                    style: TextStyle(fontSize: 10),
                  ),
                  new Flexible(
                    child: new TextField(
                      decoration:
                          const InputDecoration(helperText: "Enter App ID"),
                      style: Theme.of(context).textTheme.body1,
                    ),
                  ),
                ],
              ),
            )));

    overlayState.insert(entry);
  }

  Widget _generateBookshelvesScreen() {
    print('showing bookshelves');
    if (_bookshelves.length == 0) {
      return Center(
          child: TextField(
        decoration: InputDecoration(
            border: InputBorder.none, hintText: 'Please enter a search term'),
      ));
    }

    return Container(
      child: _getBookshelfList(),
    );
  }

  Widget _getBookshelfList() {
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
