import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/model/book.dart';
import 'package:ebook_reader/model/constants.dart';
import 'package:ebook_reader/style/text_styles.dart';
import 'package:ebook_reader/service/book_service.dart';
import 'package:ebook_reader/service/epub_book_service.dart';
import 'package:ebook_reader/bloc/book_bloc.dart';
import 'package:ebook_reader/view/book_view.dart';
import 'dart:io';

class BookListViewer extends StatefulWidget {
  final BookShelf bookshelf;
  BookListViewer({Key key, @required this.bookshelf}) : super(key: key);

  @override
  BookListViewerState createState() => new BookListViewerState();
}

class BookListViewerState extends State<BookListViewer> {
  String viewType = Constants.LIST_VIEW;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bookBloc.fetchBooksByBookshelfId(widget.bookshelf.id);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.bookshelf.name),
        ),
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
      body: new Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: generateBooksView(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          importBook();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget generateBooksView() {
    return new StreamBuilder(
        stream: bookBloc.allBooksFromBookShelf,
        builder: (context, AsyncSnapshot<List<Book>> snapshot) {
          print("Snapshot" + snapshot.data.toString());
          if (snapshot.hasData && snapshot.data.length != 0) {
            if (viewType == Constants.LIST_VIEW) {
              return buildList(snapshot);
            } else {
              return buildGrid(snapshot);
            }
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }

          return Center(child: CircularProgressIndicator());
        });
  }

  Widget buildList(AsyncSnapshot<List<Book>> snapshot) {
    return ListView.separated(
        separatorBuilder: (context, i) => Divider(),
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int i) {
          return ListTile(
            leading: SizedBox(
              height: 80,
              width: 50,
              child: Image.file(
                new File(snapshot.data[i].coverArtPath),
                fit: BoxFit.fitWidth,
              ),
            ),
            title: Text(
              snapshot.data[i].name.trim(),
              style: TextStyles.biggerFont,
            ),
            subtitle: Text(
              snapshot.data[i].authorName,
            ),
            onTap: () {
              openBook(snapshot.data[i]);
            },
          );
        });
  }

  Widget buildGrid(AsyncSnapshot<List<Book>> snapshot) {
    return GridView.builder(
        itemCount: snapshot.data.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, childAspectRatio: 0.7),
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            child: Card(
              elevation: 3.0,
              child: new SizedBox(
                height: 500,
                child: Image.file(
                  new File(snapshot.data[i].coverArtPath),
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
            onTap: () {
              openBook(snapshot.data[i]);
            },
          );
        });
  }

  void addBook(String filePath) {
    print("Found" + filePath);

    //bloc.addBook(widget.bookshelf.id, WordPair.random().asPascalCase);
    setState(() {});
  }

  void importBook() async {
    try {
      String filePath = await FilePicker.getFilePath(
          type: FileType.CUSTOM, fileExtension: 'epub');
      print("## File Path $filePath");
      BookService bookService = new EpubBookService();
      await bookService.importBook(filePath, widget.bookshelf.id);

      setState(() {});
    } on Exception catch (e) {
      print("## No File Selected" + e.toString());
    }
  }

  void openBook(Book book) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BookViewer(book: book)),
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
      case Constants.DELETE_ALL:
        bookBloc.deleteAllBooks();
        setState(() {});
        break;
      default:
    }
  }

  void showContextualMenu() {}
}
