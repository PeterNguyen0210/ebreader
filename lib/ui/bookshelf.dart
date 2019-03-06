import 'package:flutter/material.dart';
import 'package:ebook_reader/model/bookshelf.dart';

class BookShelfViewer extends StatefulWidget {

  final BookShelf bookshelf;
  BookShelfViewer({Key key, @required this.bookshelf}) : super(key: key);

  @override
  BookShelfViewerState createState() => new BookShelfViewerState();
}

class BookShelfViewerState extends State<BookShelfViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bookshelf'),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.more_vert), onPressed: openBook)
        ],
      ),
      body: new Container(
        child: new Text(widget.bookshelf.toString()),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addBook();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void addBook() {}
  void openBook() {}
}
