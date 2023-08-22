import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class UncompressPresentation {
  final FileService _fileService;

  UncompressPresentation(this._fileService);

  Future<void> extractZipFile({
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
}
