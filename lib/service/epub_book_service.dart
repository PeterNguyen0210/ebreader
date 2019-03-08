import 'package:ebook_reader/service/book_service.dart';
import 'package:ebook_reader/model/book.dart';
import 'package:ebook_reader/util/app_util.dart';
import 'package:xml/xml.dart' as xml;
import 'dart:io';

class EpubBookService extends BookService {
  Future<Book> parseBookMetadata(
      String bookDirectory, String filePath, int bookshelfId) async {
    /**
    * Reading metadata of a EPUB book has 3 main steps.
    * 1. Locating the container.xml file (Found in /META-INF/ folder)
    * 2. Parse container.xml to get the location of content.opf file (Usually found in /OEBPS/ folder)
    * 3. Parse content.opf file to get the book metadata.
  */
    String contentPath;
    Book book = new Book();
    try {
      //Step 1
      String container =
          await File('$bookDirectory/META-INF/container.xml').readAsString();

      //Step 2
      var rootFileXML = xml.parse(container).findAllElements("rootfile");
      for (var rootFile in rootFileXML) {
        contentPath = rootFile.getAttribute("full-path");
      }

      // Step 3
      var parsedContent =
          xml.parse(await File('$bookDirectory/$contentPath').readAsString());
      var metadataElement = parsedContent.findAllElements("metadata").first;

      // Getting book data from metadata element
      book.name = metadataElement.findElements("dc:title").first.text;
      book.authorName = metadataElement.findElements("dc:creator").first.text;
      book.filePath = filePath;
      book.bookshelfId = bookshelfId;
      book.coverArtPath = await findOrCreateCoverArt(
          parsedContent.findAllElements("manifest").first,
          bookDirectory + "/" + contentPath.split("/").removeAt(0),
          book.name);

      return book;
    } on Exception catch (e) {
      print("Exception occured while reading/parsing container file $e");
    }

    return null;
  }

  Future<String> findOrCreateCoverArt(xml.XmlElement manifestElement,
      String contentPath, String bookName) async {
    var coverElement = manifestElement.findElements("item").where((item) =>
        item.getAttribute("media-type") == 'image/jpeg' &&
        item.getAttribute("id").contains("cover"));

    if (coverElement.length != 0) {
      return await saveCoverArt(
          contentPath + "/" + coverElement.first.getAttribute("href"),
          bookName);
    }

    // If cover image is not found generate cover-art for the book
    print("## Cover Art not found");
    return "";
  }

  // Save the cover art to app's private directory and returns that path
  Future<String> saveCoverArt(String path, String bookName) async {
    var source = new File(path);
    String newPath = await AppUtil.localPath;
    newPath += "/$bookName.jpg";

    source.rename(newPath);
    return newPath;
  }
}
