import 'dart:io';
import 'package:path_provider/path_provider.dart';

class LogFileHelper {
  /// Returns the logs directory (creates it if missing)
  static Future<Directory> logsDirectory() async {
    final dir = await getApplicationDocumentsDirectory();
    final logDir = Directory('${dir.path}/logs');
    if (!await logDir.exists()) await logDir.create(recursive: true);
    return logDir;
  }

  /// Lists log files ordered by name descending (newest first)
  static Future<List<File>> listLogFiles() async {
    final logDir = await logsDirectory();
    final items = await logDir.list().toList();
    final files = items.whereType<File>().toList();
    files.sort((a, b) => b.path.compareTo(a.path));
    return files;
  }

}
