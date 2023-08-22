import 'dart:io';

import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class GetPresentationPath {
  final FileService _fileService;

  GetPresentationPath(this._fileService);

  final _pathSeparator = Platform.pathSeparator;

  Future<String> getBasePath() async {
    final appDocDirPath = await _fileService.getAppDocumentsDirectoryPath();
    return '$appDocDirPath${_pathSeparator}presentations';
  }

  Future<(String, String, String)> getAllPaths(String fileName) async {
    final basePath = await getBasePath();
    final filePath = '$basePath$_pathSeparator$fileName';
    final dirName = fileName.split('.zip').first;
    final dirPath = '$basePath$_pathSeparator$dirName';
    return (basePath, filePath, dirPath);
  }
}
