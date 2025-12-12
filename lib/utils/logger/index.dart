import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';
import './file_logger.dart';

class Log {
  static Logger? _logger;
  static bool _enabled = true;

  /// 初始化日志配置（可选调用，默认已配置基础参数）
  static void initialize({
    int methodCount = 0,
    int errorMethodCount = 8,
    int lineLength = 120,
    bool colors = true,
    bool printEmojis = true,
    DateTimeFormatter dateTimeFormat = DateTimeFormat.dateAndTime,
    int retainDays = 30, 
    bool? persistErrorsToFile,
    LogFilter? logFilter,
  }) {
    final printer = PrettyPrinter(
      methodCount: methodCount,
      errorMethodCount: errorMethodCount,
      lineLength: lineLength,
      colors: colors,
      printEmojis: printEmojis,
      dateTimeFormat: dateTimeFormat,
    );

    // build 模式下持久化错误日志到文件
    final persist = persistErrorsToFile ?? kReleaseMode;
    final activeFilter =
        logFilter ?? (kReleaseMode ? ProductionFilter() : DevelopmentFilter());

    if (persist) {
      // 配置日志保留多少天
      try {
        FileLogOutput().configure(retainDays: retainDays);
      } catch (_) {}
      _logger = Logger(
        printer: printer,
        filter: activeFilter,
        output: MultiOutput([ConsoleOutput(), FileLogOutput()]),
      );
    } else {
      _logger = Logger(printer: printer, filter: activeFilter);
    }
  }

  /// 释放并关闭持久化输出（在应用关闭或需要清理时调用）
  static Future<void> dispose() async {
    try {
      await FileLogOutput().destroy();
    } catch (_) {}
    _logger = null;
  }

  /// 日志开关控制
  static void enable() => _enabled = true;

  static void disable() => _enabled = false;

  /// 不同级别日志输出
  static void trace(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!_enabled) return;
    _logger?.t(message, error: error, stackTrace: stackTrace);
  }

  static void debug(dynamic message) {
    if (!_enabled) return;
    _logger?.d(message);
  }

  static void info(dynamic message) {
    if (!_enabled) return;
    _logger?.i(message);
  }

  static void warning(dynamic message) {
    if (!_enabled) return;
    _logger?.w(message);
  }

  static void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (!_enabled) return;
    _logger?.e(message, error: error, stackTrace: stackTrace);
  }

  static void fatal(dynamic message) {
    if (!_enabled) return;
    _logger?.f(message);
  }
}
