import 'package:path_provider/path_provider.dart';

class AppUtil {
  static Future<String> get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<String> get tmpPath async {
    final directory = await getTemporaryDirectory();
    return directory.path;
  }
}
