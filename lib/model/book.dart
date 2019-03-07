import 'dart:convert';

class Book {
  int id;
  int bookshelfId;
  String name;
  String authorName;
  String filePath;
  String coverArtPath;

  Book(
      {this.id,
      this.bookshelfId,
      this.name,
      this.authorName,
      this.filePath,
      this.coverArtPath});

  factory Book.fromMap(Map<String, dynamic> json) => new Book(
      id: json["id"],
      bookshelfId: json["bookshelf_id"],
      name: json["name"],
      authorName: json["author_name"],
      filePath: json['file_path'],
      coverArtPath: json['cover_art_path']);

  Map<String, dynamic> toMap() => {
        "id": id,
        "bookshelf_id": bookshelfId,
        "name": name,
        "author_name": authorName,
        "file_path": filePath,
        "cover_art_path": coverArtPath,
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
