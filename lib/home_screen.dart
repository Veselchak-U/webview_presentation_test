import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation_test/webview_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const name1 = 'Calquence_RU_3_2022_Publish';
  static const url1 =
      'https://drive.google.com/uc?export=download&confirm=no_antivirus&id=1_33cRbPzWpT-hUrcF-Z0wvqyUZtD93Iv';
  static const fileName1 = 'Calquence_RU_3_2022_Publish.zip';

  String entryPoint = '';

  Future<void> downloadFile() async {
    final dio = Dio();
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName1';
    debugPrint('!!! downloadFile() filePath = "$filePath"');
    try {
      final oldFile = File(filePath);
      if (oldFile.existsSync()) {
        debugPrint('!!! downloadFile() old file exists, deleting...');
        oldFile.deleteSync();
        debugPrint('!!! downloadFile() old file deleted');
      }
      await dio.download(
        url1,
        filePath,
        onReceiveProgress: onReceiveProgress,
      );
      debugPrint('!!! downloadFile() complete');
      showToast('Download complete');
    } catch (error) {
      debugPrint('!!! downloadFile() error: $error');
      showToast('Download error: $error');
    }
  }

  void onReceiveProgress(int received, int total) {
    debugPrint('!!! onReceiveProgress() total: $total received: $received');
    if (total != -1) {
      debugPrint(
          '!!! onReceiveProgress() ${(received / total * 100).toStringAsFixed(0)}%');
    }
  }

  Future<void> uncompressFile() async {
    debugPrint('!!! uncompressFile() start');
    final dir = await getTemporaryDirectory();
    final filePath = '${dir.path}/$fileName1';
    final file = File(filePath);
    try {
      await ZipFile.extractToDirectory(
        zipFile: file,
        destinationDir: dir,
        onExtracting: onExtracting,
      );
      debugPrint('!!! uncompressFile() complete');
      showToast('Uncompress complete');
    } catch (error) {
      debugPrint('!!! uncompressFile() error: $error');
      showToast('Uncompress error: $error');
    }
  }

  ZipFileOperation onExtracting(ZipEntry zipEntry, double progress) {
    print('!!! uncompressFile() progress: ${progress.toStringAsFixed(1)}%');
    // print('name: ${zipEntry.name}');
    return ZipFileOperation.includeItem;
  }

  Future<void> findEntryPoint() async {
    final dir = await getTemporaryDirectory();
    final dirName = fileName1.split('.zip').first;
    final presentationPath = Directory('${dir.path}/$dirName');
    await for (var entity
        in presentationPath.list(recursive: true, followLinks: false)) {
      final fileName = entity.path.split('/').last;
      if (fileName == 'index.html') {
        entryPoint = entity.path;
        debugPrint('!!! findEntryPoint() complete');
        showToast('index.html found');
        break;
      }
    }
    if (entryPoint.isEmpty) {
      debugPrint('!!! findEntryPoint() not found');
      showToast('index.html NOT found');
    }
  }

  void openPresentation() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WebViewScreen(entryPoint)),
    );
  }

  void showToast(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Presentation test'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('Презентация: $name1'),
            const Text('URL: $url1'),
            TextButton(
              onPressed: downloadFile,
              child: const Text('Скачать презентацию'),
            ),
            TextButton(
              onPressed: uncompressFile,
              child: const Text('Распаковать презентацию'),
            ),
            TextButton(
              onPressed: findEntryPoint,
              child: const Text('Найти index.html'),
            ),
            TextButton(
              onPressed: openPresentation,
              child: const Text('Открыть презентацию'),
            ),
          ],
        ),
      ),
    );
  }
}
