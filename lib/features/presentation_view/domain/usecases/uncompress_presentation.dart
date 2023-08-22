import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class UncompressPresentation {
  final FileService _fileService;

  UncompressPresentation(this._fileService);

  Future<void> extractZip({
    required String filePath,
    required String destinationPath,
    void Function(double)? onExtracting,
  }) async {
    await _fileService.extractZipFile(
      filePath: filePath,
      destinationPath: destinationPath,
      onExtracting: onExtracting,
    );
  }

  Future<void> extractAllZips({
    required String dirPath,
    void Function(double)? onExtracting,
  }) async {
    await _fileService.extractAllZips(
      dirPath: dirPath,
      onExtracting: onExtracting,
    );
  }
}
