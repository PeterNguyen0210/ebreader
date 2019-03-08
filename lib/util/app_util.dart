import 'package:path_provider/path_provider.dart';
import 'package:crypto/crypto.dart';
import 'dart:io';

class AppUtil {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get tmpPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }

  static String generateUniqueIdForBook(String filePath) {
    var data = new File(filePath).readAsBytesSync();
    String id = md5.convert(data).toString();
    print("## Unique ID : $id");
    return id;
  }
}
