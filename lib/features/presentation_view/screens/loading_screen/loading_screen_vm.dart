import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation_test/core/api/dio_client.dart';
import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';
import 'package:presentation_test/features/presentation_view/screens/webview_screen/inapp_webview_screen.dart';

enum LoadingStatus { notLoaded, loaded, unpacked, ready }

class LoadingScreenVm extends ChangeNotifier {
  final BuildContext context;
  final FileService fileService;
  final DioClient dioClient;

  LoadingScreenVm(
    this.context, {
    required this.fileService,
    required this.dioClient,
  }) {
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
    if (!await fileService.fileExist(filePath)) {
      status = LoadingStatus.notLoaded;
      return;
    }
    if (!await fileService.directoryExist(dirPath)) {
      status = LoadingStatus.loaded;
      return;
    }
    await findEntryPoint();
    if (_entryPoint.isEmpty) {
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

  CancelToken? _cancelToken;
  String _entryPoint = '';

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
      // await deleteOldFiles();
      _cancelToken = CancelToken();
      await dioClient.downloadRequest(
        presentationUrl,
        filePath,
        onReceiveProgress: _onReceiveProgress,
        cancelToken: _cancelToken,
      );
      _cancelToken = null;
      status = LoadingStatus.loaded;
    } catch (error) {
      showToast('Ошибка загрузки: $error');
    }
    progressLabel = '';
    loading = false;
  }

  Future<void> deleteOldFiles() async {
    await fileService.deleteFile(filePath);
    await fileService.deleteDirectory(dirPath);
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      progressLabel =
          'Скачивание: ${(received / total * 100).toStringAsFixed(1)}%';
    }
  }

  Future<void> cancelDownloading() async {
    _cancelToken?.cancel('Пользователь остановил загрузку');
  }

  Future<void> uncompressFile() async {
    loading = true;
    try {
      await fileService.extractZipFile(
        filePath: filePath,
        destinationPath: dirPath,
        onExtracting: _onExtracting,
      );
      status = LoadingStatus.unpacked;
    } catch (error) {
      showToast('Ошибка распаковки: $error');
    }
    progressLabel = '';
    loading = false;
  }

  void _onExtracting(double progress) {
    progressLabel = 'Распаковка: ${progress.toStringAsFixed(1)}%';
  }

  Future<void> findEntryPoint() async {
    loading = true;
    final filePaths = await fileService.findFile('index.html', dirPath);
    if (filePaths.isEmpty) {
      showToast('Файл "index.html" не найден');
    } else {
      _entryPoint = filePaths.first;
      status = LoadingStatus.ready;
    }
    loading = false;
  }

  Future<void> deleteAll() async {
    loading = true;
    try {
      await fileService.deleteDirectory(basePath);
      await fileService.createDirectory(basePath);
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
          filePath: _entryPoint,
          dirPath: dirPath,
        ),

        // builder: (context) => InappWebServerScreen(entryPoint),
      ),
    );
  }
}
