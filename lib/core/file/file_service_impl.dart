import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class FileServiceImpl implements FileService {
  final _pathSeparator = Platform.pathSeparator;

  @override
  Future<String> getAppDocumentsDirectoryPath() async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return appDocDir.path;
  }

  @override
  Future<bool> fileExist(String path) {
    final file = File(path);
    return file.exists();
  }

  @override
  Future<bool> directoryExist(String path) {
    final dir = Directory(path);
    return dir.exists();
  }

  @override
  Future<void> deleteFile(String path) async {
    final file = File(path);
    if (await file.exists()) {
      await file.delete();
    }
  }

  @override
  Future<void> deleteDirectory(String path) async {
    final dir = Directory(path);
    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  @override
  Future<void> createDirectory(String path) async {
    final dir = Directory(path);
    await dir.create();
  }

  @override
  Future<List<String>> findFile(String fileName, String startPath) async {
    final result = <String>[];
    final startDir = Directory(startPath);
    await for (final fsEntity
        in startDir.list(recursive: true, followLinks: false)) {
      final stat = await fsEntity.stat();
      final isFile = stat.type == FileSystemEntityType.file;
      final name = fsEntity.path.split(_pathSeparator).last;
      if (isFile && name == fileName) {
        result.add(fsEntity.path);
      }
    }
    result.sort(
      (a, b) {
        final depthA = a.split(_pathSeparator).length;
        final depthB = b.split(_pathSeparator).length;
        return depthA != depthB ? depthA.compareTo(depthB) : a.compareTo(b);
      },
    );

    return result;
  }

  @override
  Future<void> extractZipFile({
    required String filePath,
    required String destinationPath,
    void Function(double)? onExtracting,
  }) async {
    await ZipFile.extractToDirectory(
      zipFile: File(filePath),
      destinationDir: Directory(destinationPath),
      onExtracting: onExtracting == null
          ? null
          : (_, progress) {
              onExtracting(progress);
              return ZipFileOperation.includeItem;
            },
    );
  }

  @override
  Future<void> extractAllZips({
    required String dirPath,
    void Function(double)? onExtracting,
  }) async {
    final zipPaths = <String>[];
    final startDirPath =
        dirPath.endsWith(_pathSeparator) ? dirPath : dirPath + _pathSeparator;

    final startDir = Directory(startDirPath);
    await for (final fsEntity
        in startDir.list(recursive: true, followLinks: false)) {
      final stat = await fsEntity.stat();
      final isFile = stat.type == FileSystemEntityType.file;
      final name = fsEntity.path.split(_pathSeparator).last;
      if (isFile && name.toLowerCase().endsWith('.zip')) {
        zipPaths.add(fsEntity.path);
      }
    }
    for (var i = 0; i < zipPaths.length; i++) {
      final filePath = zipPaths[i];
      final destinationPath = _getDestinationPath(filePath);
      await extractZipFile(
        filePath: filePath,
        destinationPath: destinationPath,
      );
      onExtracting?.call(i + 1 / zipPaths.length);
    }
  }

  String _getDestinationPath(String zipPath) {
    final fileName = zipPath.split(_pathSeparator).last;
    if (fileName.toLowerCase().endsWith('_shared.zip')) {
      final dirPath = zipPath.substring(0, zipPath.length - fileName.length);
      return '${dirPath}shared';
    }
    return zipPath.substring(0, zipPath.length - '.zip'.length);
  }
}
