import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class DeletePresentation {
  final FileService _fileService;

  DeletePresentation(this._fileService);

  Future<void> delete(String filePath, String dirPath) async {
    await _fileService.deleteFile(filePath);
    await _fileService.deleteDirectory(dirPath);
  }

  Future<void> deleteAll(String basePath) async {
    await _fileService.deleteDirectory(basePath);
    await _fileService.createDirectory(basePath);
  }
}
