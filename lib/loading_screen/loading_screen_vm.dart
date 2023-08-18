import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation_test/webview_screen/inapp_webview_screen.dart';

enum LoadingStatus { notLoaded, loaded, unpacked, ready }

class LoadingScreenVm extends ChangeNotifier {
  final BuildContext context;

  LoadingScreenVm(this.context) {
    _init();
  }

  Future<void> _init() async {
    await _initPaths();
    await _checkStatus();
  }

  Future<void> _initPaths() async {
    final appDir = await getApplicationDocumentsDirectory();
    basePath = '${appDir.path}${pathSeparator}presentations';
    filePath = '$basePath$pathSeparator$presentationFileName';
    dirPath = '$basePath$pathSeparator$presentationDirName';
  }

  Future<void> _checkStatus() async {
    final filePath = '$basePath$pathSeparator$presentationFileName';
    final file = File(filePath);
    if (!await file.exists()) {
      status = LoadingStatus.notLoaded;
      return;
    }
    final dir = Directory('$basePath$pathSeparator$presentationDirName');
    if (!await dir.exists()) {
      status = LoadingStatus.loaded;
      return;
    }
    await findEntryPoint();
    if (entryPoint.isEmpty) {
      status = LoadingStatus.unpacked;
      return;
    }
    status = LoadingStatus.ready;
  }

  /// Regular properties
  ///

  final presentationName = 'Calquence_RU_3_2022_Publish';
  final presentationUrl =
      'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1_33cRbPzWpT-hUrcF-Z0wvqyUZtD93Iv';
  final presentationFileName = 'Calquence_RU_3_2022_Publish.zip';
  final presentationDirName = 'Calquence_RU_3_2022_Publish';

  // final presentationName = 'Synagis_RIA_GI_2023_1';
  // final presentationUrl =
  //     'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1lKK-WiWvYhowvTtEOkTa3CDHqiViAOpc';
  // final presentationFileName = 'Synagis_RIA_GI_2023_1.zip';
  // final presentationDirName = 'Synagis_RIA_GI_2023_1';

  final pathSeparator = Platform.pathSeparator;

  late final String basePath;
  late final String filePath;
  late final String dirPath;

  String entryPoint = '';

  /// Reactive properties
  ///

  LoadingStatus _status = LoadingStatus.notLoaded;

  LoadingStatus get status => _status;

  set status(LoadingStatus value) {
    if (value != _status) {
      _status = value;
      notifyListeners();
    }
  }

  bool _loading = false;

  bool get loading => _loading;

  set loading(bool value) {
    if (value != _loading) {
      _loading = value;
      notifyListeners();
    }
  }

  String _progressLabel = 'Инициализация...';

  String get progressLabel => _progressLabel;

  set progressLabel(String value) {
    if (value != _progressLabel) {
      _progressLabel = value;
      notifyListeners();
    }
  }

  /// Data methods
  ///

  void nextStep() {
    switch (status) {
      case LoadingStatus.notLoaded:
        downloadFile();
        break;
      case LoadingStatus.loaded:
        uncompressFile();
        break;
      case LoadingStatus.unpacked:
        findEntryPoint();
        break;
      case LoadingStatus.ready:
        openPresentation();
        break;
    }
  }

  String get nextStepLabel {
    if (loading && progressLabel.isNotEmpty) {
      return progressLabel;
    }
    switch (status) {
      case LoadingStatus.notLoaded:
        return 'Скачать презентацию';
      case LoadingStatus.loaded:
        return 'Распаковать презентацию';
      case LoadingStatus.unpacked:
        return 'Найти index.html';
      case LoadingStatus.ready:
        return 'Открыть презентацию';
    }
  }

  Future<void> downloadFile() async {
    loading = true;
    try {
      await deleteOldFiles();
      final dio = Dio();
      await dio.download(
        presentationUrl,
        filePath,
        onReceiveProgress: _onReceiveProgress,
      );
      status = LoadingStatus.loaded;
    } catch (error) {
      showToast('Ошибка загрузки: $error');
    }
    progressLabel = '';
    loading = false;
  }

  Future<void> deleteOldFiles() async {
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
      debugPrint('!!! deleteOldFiles() old file deleted');
    }
    final dir = Directory(dirPath);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
      debugPrint('!!! deleteOldFiles() old dir deleted');
    }
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      progressLabel =
          'Скачивание: ${(received / total * 100).toStringAsFixed(1)}%';
    }
  }

  Future<void> uncompressFile() async {
    loading = true;
    final file = File(filePath);
    final destinationDir = Directory(dirPath);
    try {
      await ZipFile.extractToDirectory(
        zipFile: file,
        destinationDir: destinationDir,
        onExtracting: _onExtracting,
      );
      status = LoadingStatus.unpacked;
    } catch (error) {
      showToast('Ошибка распаковки: $error');
    }
    progressLabel = '';
    loading = false;
  }

  ZipFileOperation _onExtracting(ZipEntry zipEntry, double ready) {
    progressLabel = 'Распаковка: ${ready.toStringAsFixed(1)}%';
    return ZipFileOperation.includeItem;
  }

  Future<void> findEntryPoint() async {
    loading = true;
    final presentationPath = Directory(dirPath);
    final filePaths = <String>[];
    await for (var entity
        in presentationPath.list(recursive: true, followLinks: false)) {
      final fileName = entity.path.split(pathSeparator).last;
      if (fileName == 'index.html') {
        filePaths.add(entity.path);
      }
    }
    if (filePaths.isEmpty) {
      showToast('Файл "index.html" не найден');
    } else {
      entryPoint = _getRootFile(filePaths);
      status = LoadingStatus.ready;
    }
    loading = false;
  }

  String _getRootFile(List<String> filePaths) {
    filePaths.sort();
    String nearest = filePaths.first;
    int nearestDepth = nearest.split(pathSeparator).length;
    for (var path in filePaths) {
      final currentDepth = path.split(pathSeparator).length;
      if (currentDepth < nearestDepth) {
        nearest = path;
        nearestDepth = currentDepth;
      }
    }
    return nearest;
  }

  Future<void> deleteAll() async {
    loading = true;
    try {
      final baseDir = Directory(basePath);
      await baseDir.delete(recursive: true);
      await baseDir.create();
      status = LoadingStatus.notLoaded;
      showToast('Удаление завершено');
    } catch (error) {
      showToast('Ошибка удаления: $error');
    }
    loading = false;
  }

  /// Navigation methods
  ///

  void showToast(String message) {
    debugPrint('!!! showToast() message: $message');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void openPresentation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => WebViewScreen(entryPoint),

        builder: (context) => InappWebViewScreen(
          filePath: entryPoint,
          dirPath: dirPath,
        ),

        // builder: (context) => InappWebServerScreen(entryPoint),
      ),
    );
  }
}
