import 'package:flutter/material.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_entity.dart';
import 'package:presentation_test/features/presentation_view/domain/entities/presentation_status.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/check_presentation_status.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/delete_presentation.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/download_presentation.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/get_presentation_paths.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/uncompress_presentation.dart';
import 'package:presentation_test/features/presentation_view/screens/webview_screen/inapp_webview_screen.dart';

class LoadingScreenVm extends ChangeNotifier {
  final BuildContext context;
  final GetPresentationPath _getPresentationPath;
  final CheckPresentationStatus _checkPresentationStatus;
  final DownloadPresentation _downloadPresentation;
  final UncompressPresentation _uncompressPresentation;
  final DeletePresentation _deletePresentation;

  LoadingScreenVm(
    this.context, {
    required GetPresentationPath getPresentationPath,
    required CheckPresentationStatus checkPresentationStatus,
    required DownloadPresentation downloadPresentation,
    required UncompressPresentation uncompressPresentation,
    required DeletePresentation deletePresentation,
  })  : _deletePresentation = deletePresentation,
        _uncompressPresentation = uncompressPresentation,
        _downloadPresentation = downloadPresentation,
        _checkPresentationStatus = checkPresentationStatus,
        _getPresentationPath = getPresentationPath;

  Future<void> init(PresentationEntity presentation) async {
    this.presentation = presentation;
    await _initPaths();
    await _checkStatus();
  }

  Future<void> _initPaths() async {
    final paths = await _getPresentationPath.getAllPaths(presentation.fileName);
    _basePath = paths.$1;
    _filePath = paths.$2;
    _dirPath = paths.$3;
  }

  Future<void> _checkStatus() async {
    status = await _checkPresentationStatus.checkStatus(_filePath, _dirPath);
  }

  /// Regular properties
  ///

  late final PresentationEntity presentation;
  late final String _basePath;
  late final String _filePath;
  late final String _dirPath;

  bool get isError => status.maybeWhen(
        error: (_, __) => true,
        orElse: () => false,
      );

  // CancelToken? _cancelToken;

  /// Reactive properties
  ///

  PresentationStatus _status = const PresentationStatus.notLoaded();

  PresentationStatus get status => _status;

  set status(PresentationStatus value) {
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
    status.when(
      notLoaded: () => _downloadFile(),
      loaded: () => _uncompressFile(),
      unpacked: () => _findEntryPoint(),
      ready: (entryPoint) => _openPresentation(entryPoint, _dirPath),
      error: (_, lastStatus) => _repeatAction(lastStatus),
    );
  }

  void _repeatAction(PresentationStatus lastStatus) {
    status = lastStatus;
    nextStep();
  }

  String get nextStepLabel {
    if (loading && progressLabel.isNotEmpty) {
      return progressLabel;
    }
    return status.when(
      notLoaded: () => 'Скачать презентацию',
      loaded: () => 'Распаковать презентацию',
      unpacked: () => 'Найти index.html',
      ready: (_) => 'Открыть презентацию',
      error: (_, lastStatus) {
        final lastOperation = lastStatus.when(
          notLoaded: () => 'скачивание',
          loaded: () => 'распаковку',
          unpacked: () => 'поиск index.html',
          ready: (_) => '',
          error: (_, __) => '',
        );
        return 'Повторить $lastOperation';
      },
    );
  }

  void showError() {
    status.maybeWhen(
      error: (message, __) => _showToast(message),
      orElse: () => {},
    );
  }

  Future<void> _downloadFile() async {
    loading = true;
    try {
      // await deleteOldFiles();
      await _downloadPresentation.download(
        presentation.url,
        _filePath,
        onReceiveProgress: _onReceiveProgress,
      );
      status = const PresentationStatus.loaded();
    } catch (error) {
      status = PresentationStatus.error(
        'Ошибка загрузки: $error',
        lastStatus: const PresentationStatus.notLoaded(),
      );
    }
    progressLabel = '';
    loading = false;
  }

  Future<void> _deleteOldFiles() async {
    await _deletePresentation.delete(_filePath, _dirPath);
  }

  void _onReceiveProgress(int received, int total) {
    if (total != -1) {
      progressLabel =
          'Скачивание: ${(received / total * 100).toStringAsFixed(1)}%';
    }
  }

  Future<void> cancelDownloading() async {
    // _cancelToken?.cancel('Пользователь остановил загрузку');
  }

  Future<void> _uncompressFile() async {
    loading = true;
    try {
      await _uncompressPresentation.extractZip(
        filePath: _filePath,
        destinationPath: _dirPath,
        onExtracting: (progress) => _onExtracting(1, progress),
      );
      progressLabel = '';
      await _uncompressPresentation.extractAllZips(
        dirPath: _dirPath,
        onExtracting: (progress) => _onExtracting(2, progress),
      );
      status = const PresentationStatus.unpacked();
    } catch (error) {
      status = PresentationStatus.error(
        'Ошибка распаковки: $error',
        lastStatus: const PresentationStatus.loaded(),
      );
    }
    progressLabel = '';
    loading = false;
  }

  void _onExtracting(int step, double progress) {
    progressLabel = 'Распаковка (шаг $step): ${progress.toStringAsFixed(1)}%';
  }

  Future<void> _findEntryPoint() async {
    loading = true;
    final entryPoint = await _checkPresentationStatus.findEntryPoint(
      'index.html',
      _dirPath,
    );
    if (entryPoint.isEmpty) {
      status = const PresentationStatus.error(
        'Файл "index.html" не найден',
        lastStatus: PresentationStatus.unpacked(),
      );
    } else {
      status = PresentationStatus.ready(entryPoint);
    }
    loading = false;
  }

  Future<void> deleteAll() async {
    loading = true;
    try {
      await _deletePresentation.deleteAll(_basePath);
      status = const PresentationStatus.notLoaded();
      _showToast('Удаление завершено');
    } catch (error) {
      _showToast('Ошибка удаления: $error');
    }
    loading = false;
  }

  /// Navigation methods
  ///

  void _showToast(String message) {
    debugPrint('!!! showToast() message: $message');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _openPresentation(String filePath, String dirPath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => WebViewScreen(entryPoint),

        builder: (context) => InappWebViewScreen(
          filePath: filePath,
          dirPath: dirPath,
        ),

        // builder: (context) => InappWebServerScreen(entryPoint),
      ),
    );
  }
}
