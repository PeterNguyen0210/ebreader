import 'package:flutter/material.dart';

import 'package:ebook_reader/model/book.dart';

class BookViewer extends StatefulWidget {
  final Book book;
  BookViewer({Key key, @required this.book}) : super(key: key);

  @override
  BookViewerState createState() => new BookViewerState();
}

class BookViewerState extends State<BookViewer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Text(widget.book.name),
    ));
  }
}
