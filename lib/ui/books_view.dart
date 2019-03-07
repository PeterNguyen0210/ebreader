import 'package:flutter/material.dart';
import 'package:ebook_reader/model/bookshelf.dart';
import 'package:ebook_reader/bloc/bookshelf_bloc.dart';
import 'package:ebook_reader/model/book.dart';
import 'package:english_words/english_words.dart';
import 'package:ebook_reader/model/constants.dart';
import 'package:ebook_reader/style/text_styles.dart';
import 'package:file_picker/file_picker.dart';

class BookShelfViewer extends StatefulWidget {
  final BookShelf bookshelf;
  BookShelfViewer({Key key, @required this.bookshelf}) : super(key: key);

  @override
  BookShelfViewerState createState() => new BookShelfViewerState();
}

class BookShelfViewerState extends State<BookShelfViewer> {
  String viewType = Constants.LIST_VIEW;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchBooksByBookshelfId(widget.bookshelf.id);
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
      body: generateBooksView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          getFilePath();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget generateBooksView() {
    return new StreamBuilder(
        stream: bloc.allBooksFromBookShelf,
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
            title: Text(
              snapshot.data[i].name,
              style: TextStyles.biggerFont,
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
        gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int i) {
          return GestureDetector(
            child: Card(
              elevation: 5.0,
              child: new Container(
                alignment: Alignment.center,
                child: new Text(snapshot.data[i].name),
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

  void getFilePath() async {
    try {
      String filePath = await FilePicker.getFilePath(type: FileType.ANY);
      addBook(filePath);
    } on Exception catch (e) {
      print("## No File Selected");
    }
  }

  void openBook(Book book) {}
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
