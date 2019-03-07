import 'package:ebook_reader/service/book_service.dart';
import 'package:ebook_reader/model/book.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:io';

class EpubBookService extends BookService {
  Future<Book> parseBookMetadata(String bookDirectory) async {
    /**
    * Reading metadata of a EPUB book has 3 main steps.
    * 1. Locating the container.xml file (Found in /META-INF/ folder)
    * 2. Parse container.xml to get the location of content.opf file (Usually found in /OEBPS/ folder)
    * 3. Parse content.opf file to get the book metadata.
  */
    String contentPath;

    try {
      String container =
          await File('$bookDirectory/META-INF/container.xml').readAsString();
      var rootFileXML = xml.parse(container).findAllElements("rootfile");
      for (var rootFile in rootFileXML) {
        contentPath = rootFile.getAttribute("full-path");
      }

      String content = await File('$bookDirectory/$contentPath').readAsString();
      var metadata = xml.parse(content).findElements("metadata");
      print("Metadata $metadata");
      
    } on Exception catch (e) {
      print("Exception occured while reading/parsing container file $e");
    }

    return null;
  }
}
