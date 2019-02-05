import 'dart:convert';

class BookShelf {
  int id;
  String name;

  BookShelf({
    this.id,
    this.name,
  });

  factory BookShelf.fromMap(Map<String, dynamic> json) => new BookShelf(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

BookShelf bookshelfFromJson(String str) {
  final jsonData = json.decode(str);
  return BookShelf.fromMap(jsonData);
}

String bookshelfToJson(BookShelf data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}
