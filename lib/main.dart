import 'package:flutter/material.dart';
import 'ui/bookshelf_view.dart';

void main() => runApp(EbookReader());

class EbookReader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.amber,
        ),
        home: new BookShelfListViewer());
  }
}
