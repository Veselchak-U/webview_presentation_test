import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class UncompressPresentation {
  final FileService _fileService;

  UncompressPresentation(this._fileService);

  Future<void> extractPresentation({
    required String filePath,
    required String destinationPath,
    void Function(double)? onExtracting,
  }) async {
    await _fileService.extractZipFile(
      filePath: filePath,
      destinationPath: destinationPath,
      onExtracting: (progress) => onExtracting?.call(progress / 2),
    );
    await _fileService.extractAllZips(
      dirPath: destinationPath,
      onExtracting: (progress) => onExtracting?.call(50 + (progress / 2)),
    );
  }
}
