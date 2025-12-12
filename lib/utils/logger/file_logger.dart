import 'dart:io';
import 'dart:convert';
import 'package:logger/logger.dart';
import './log_file_helper.dart';

/// A simple LogOutput that appends error/fatal logs to a daily file.
class FileLogOutput extends LogOutput {
  static final FileLogOutput _instance = FileLogOutput._internal();
  factory FileLogOutput() => _instance;

  FileLogOutput._internal();

  IOSink? _sink;
  int _retainDays = 30; // default keep 30 days

  Future<void> _init() async {
    if (_sink != null) return;
    final logDir = await LogFileHelper.logsDirectory();
    // 删除过期日志文件
    await _cleanupOldLogs(logDir);
    final file = File('${logDir.path}/${_fileNameForToday()}');
    _sink = file.openWrite(mode: FileMode.append, encoding: utf8);
  }

  // 根据日期生成日志文件名
  String _fileNameForToday() {
    final now = DateTime.now();
    return '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}.log';
  }

  @override
  void output(OutputEvent event) async {
    // Only write error or fatal logs
    try {
      await _init();
      final buffer = StringBuffer();
      for (final line in event.lines) {
        buffer.writeln(line);
      }
      // Only persist if level is error or fatal
      if (event.level == Level.error || event.level == Level.fatal) {
        _sink?.writeln(buffer.toString());
        await _sink?.flush();
      }
    } catch (e) {
      // ignore file write errors to avoid crashing app
    }
  }

  @override
  @override
  Future<void> destroy() async {
    await _sink?.flush();
    await _sink?.close();
    _sink = null;
  }

  /// Configure retention days (call before first write)
  void configure({int retainDays = 7}) {
    _retainDays = retainDays;
  }

  /// 删除过期日志文件
  Future<void> _cleanupOldLogs(Directory logDir) async {
    try {
      final now = DateTime.now();
      final files = await logDir.list().toList();
      for (final f in files) {
        if (f is File) {
          final name = f.uri.pathSegments.last;
          // expect file names like YYYY-MM-DD.log
          final regex = RegExp(r"^(\d{4})-(\d{2})-(\d{2})\.log$");
          final m = regex.firstMatch(name);
          if (m != null) {
            final year = int.parse(m.group(1)!);
            final month = int.parse(m.group(2)!);
            final day = int.parse(m.group(3)!);
            final fileDate = DateTime(year, month, day);
            if (now.difference(fileDate).inDays > _retainDays) {
              try {
                await f.delete();
              } catch (_) {}
            }
          }
        }
      }
    } catch (_) {}
  }
}
