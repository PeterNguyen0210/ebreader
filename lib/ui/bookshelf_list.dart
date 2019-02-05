import 'package:flutter/material.dart';
import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/bloc/bookshelf_bloc.dart';

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
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllBookshelves();
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
          addBookshelf();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _generateBookshelvesScreen() {
    print('showing bookshelves');
    if (_bookshelves.length == 0) {
      return Center(child: Text('No Bookshelf to show'));
    }

    return Container(
      child: _getBookshelfList(),
    );
  }

  Widget _getBookshelfList() {
    return new StreamBuilder(
        stream: bloc.allBookshelves,
        builder: (context, AsyncSnapshot<List<BookShelf>> snapshot) {
          if (snapshot.hasData) {
            return buildList(snapshot);
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget buildList(AsyncSnapshot<List<BookShelf>> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(
              snapshot.data[i].name,
              style: _biggerFont,
            ),
            onTap: () {
              openBookshelf(snapshot.data[i].id);
            },
          );
        });
  }

  void addBookshelf() {
    print('Adding Bookshelf');
    bloc.fetchAllBookshelves();
  }

  void openBookshelf(int id) {
    print(id);
  }

  void _openExtraOptions() {}
}
