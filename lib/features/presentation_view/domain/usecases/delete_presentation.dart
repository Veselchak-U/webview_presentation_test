import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';
import 'package:presentation_test/features/presentation_view/domain/usecases/get_presentation_paths.dart';

class DeletePresentation {
  final FileService _fileService;
  final GetPresentationPath _getPresentationPath;

  DeletePresentation(
    this._fileService,
    this._getPresentationPath,
  );

  Future<void> delete(String filePath, String dirPath) async {
    await _fileService.deleteFile(filePath);
    await _fileService.deleteDirectory(dirPath);
  }

  Future<void> deleteAll() async {
    final basePath = await _getPresentationPath.getBasePath();
    await _fileService.deleteDirectory(basePath);
    await _fileService.createDirectory(basePath);
  }
}
