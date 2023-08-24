import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

// final log = LoggerService()
//   ..init(
//     toFile: true,
//   );

class LoggerService {
  static const _filePrefix = 'presentation-test-app_';
  static const _fileExtension = '.log';
  static Logger? _logger;
  static bool _saveToFile = false;

  static bool get isLogging => _saveToFile;

  final _pathSeparator = Platform.pathSeparator;

  Future<void> init({bool? toFile}) async {
    await Future.delayed(Duration.zero); // to complete previous record
    _saveToFile = toFile ?? false;
    final logOutput = await _getLogOutput();
    _logger = Logger(
      filter: _MyFilter(),
      printer: SimplePrinter(
        printTime: true,
        colors: false,
      ),
      output: logOutput,
    );
  }

  void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.d(message, error: error, stackTrace: stackTrace);
  }

  void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    if (_logger == null) {
      throw "Logger Service isn't initialized";
    }
    _logger?.e(message, error: error, stackTrace: stackTrace);
  }

  Future<void> shareLogFile() async {
    final logPath = await getLogFilePath();
    final logExist = logPath != null && await File(logPath).exists();
    await Share.shareXFiles([
      if (logExist) XFile(logPath),
    ]);
  }

  Future<LogOutput> _getLogOutput() async {
    if (_saveToFile) {
      final logFilePath = await getLogFilePath();
      debugPrint('!!! logFilePath = $logFilePath');
      _deleteOldLogs();
      return MultiOutput([
        ConsoleOutput(),
        FileOutput(
          file: File(logFilePath!),
          overrideExisting: true,
        ),
      ]);
    } else {
      return ConsoleOutput();
    }
  }

  Future<void> _deleteOldLogs() async {
    final logFilePath = await getLogFilePath();
    final logDir = await _getLogFileDir();
    final fileList = await logDir.list().toList();
    for (var file in fileList) {
      final path = file.path;
      final name = file.path.split(_pathSeparator).last;
      if (name.startsWith(_filePrefix) &&
          name.endsWith(_fileExtension) &&
          path != logFilePath) {
        try {
          await file.delete();
          debugPrint('!!! Deleted old log file: $path');
        } catch (error) {
          debugPrint('!!! Cannot delete old log file $path: $error');
        }
      }
    }
  }

  Future<void> clearCurrentLogFile() async {
    final logFilePath = await getLogFilePath();
    if (logFilePath == null) {
      return;
    }
    try {
      final file = File(logFilePath);
      await file.delete();
      await file.create();
      debugPrint('!!! Recreated log file: $logFilePath');
    } catch (error) {
      debugPrint('!!! Cannot delete log file $logFilePath: $error');
    }
  }

  Future<String?> getLogFilePath() async {
    final logDir = await _getLogFileDir();
    final today = DateFormat('yyyyMMdd').format(DateTime.now());
    return '${logDir.path}$_pathSeparator$_filePrefix$today$_fileExtension';
  }

  Future<Directory> _getLogFileDir() async {
    Directory? logDir;
    try {
      logDir = await getExternalStorageDirectory();
    } catch (err) {
      debugPrint('!!! getExternalStorageDirectory() error: $err');
    }
    logDir ??= await getTemporaryDirectory();
    return logDir;
  }
}

class _MyFilter extends LogFilter {
  @override
  bool shouldLog(LogEvent event) {
    return true;
  }
}
