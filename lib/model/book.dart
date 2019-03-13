import 'dart:convert';

class Book {
  String id;
  String title;
  String authorName;
  String filePath;
  List<int> coverArt;

  Book({this.id, this.title, this.authorName, this.filePath, this.coverArt});

  factory Book.fromMap(Map<String, dynamic> json) => new Book(
      id: json["id"],
      title: json["title"],
      authorName: json["author_name"],
      filePath: json['file_path'],
      coverArt: json['cover_art']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "author_name": authorName,
        "file_path": filePath,
        "cover_art": coverArt,
      };
}

Book bookshelfFromJson(String str) {
  final jsonData = json.decode(str);
  return Book.fromMap(jsonData);
}

String bookshelfToJson(Book data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
