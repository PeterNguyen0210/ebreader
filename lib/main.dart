import 'package:flutter/material.dart';
import 'screens/bookshelf_list_screen.dart';

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