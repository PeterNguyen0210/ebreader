import 'package:flutter/material.dart';
import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/bloc/bookshelf_bloc.dart';
import 'package:ebook_reader/ui/bookshelf.dart';
import 'package:ebook_reader/model/constants.dart';

class BookShelfListViewer extends StatefulWidget {
  @override
  BookShelfListViewerState createState() => new BookShelfListViewerState();
}

class BookShelfListViewerState extends State<BookShelfListViewer> {
  final _biggerFont = const TextStyle(fontSize: 18);
  String viewType = Constants.LIST_VIEW;

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
          PopupMenuButton<String>(
            onSelected: doAction,
            itemBuilder: (BuildContext context) {
              return Constants.rightMenuChoices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          ),
        ],
      ),
      body: generateBookshelfList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addBookshelf();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget generateBookshelfList() {
    return new StreamBuilder(
        stream: bloc.allBookshelves,
        builder: (context, AsyncSnapshot<List<BookShelf>> snapshot) {
          if (snapshot.hasData) {
            if (viewType == Constants.LIST_VIEW) {
              return buildList(snapshot);
            } else {
              return buildGrid(snapshot);
            }
          } else if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget buildList(AsyncSnapshot<List<BookShelf>> snapshot) {
    print('Bookshelves List: ' + snapshot.data.length.toString());
    return ListView.builder(
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            title: Text(
              snapshot.data[i].name,
              style: _biggerFont,
            ),
            onTap: () {
              openBookshelf(snapshot.data[i]);
            },
          );
        });
  }

  Widget buildGrid(AsyncSnapshot<List<BookShelf>> snapshot) {
    print('Bookshelves Grid : ' + snapshot.data.length.toString());
    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int i) {
          return Card(
            elevation: 5.0,
            child: new Container(
              alignment: Alignment.center,
              child: new Text(snapshot.data[i].name),
            ),
          );
        });
  }

  void addBookshelf() {
    print('Adding Bookshelf');
    bloc.addBookshelf("Testing");
    setState(() {});
  }

  void openBookshelf(BookShelf bookshelf) {
    print(bookshelf);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BookShelfViewer(bookshelf: bookshelf)),
    );
  }

  void doAction(String choice) {
    switch (choice) {
      case Constants.GRID_VIEW:
        viewType = Constants.GRID_VIEW;
        setState(() {});
        break;
      case Constants.LIST_VIEW:
        viewType = Constants.LIST_VIEW;
        setState(() {});
        break;
      default:
    }
  }
}
