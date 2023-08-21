import 'package:presentation_test/features/presentation_view/domain/entities/presentation_status.dart';
import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class CheckPresentationStatus {
  final FileService _fileService;

  CheckPresentationStatus(this._fileService);

  Future<PresentationStatus> checkStatus(
    String filePath,
    String dirPath,
  ) async {
    try {
      if (!await _fileService.fileExist(filePath)) {
        return const PresentationStatus.notLoaded();
      }
      if (!await _fileService.directoryExist(dirPath)) {
        return const PresentationStatus.loaded();
      }
      final entryPoint = await _findEntryPoint('index.html', dirPath);
      if (entryPoint.isEmpty) {
        return const PresentationStatus.unpacked();
      }
      return PresentationStatus.ready(entryPoint);
    } catch (error) {
      return PresentationStatus.error('$error');
    }
  }

  Future<String> _findEntryPoint(String fileName, String dirPath) async {
    final founded = await _fileService.findFile(fileName, dirPath);
    return founded.isEmpty ? '' : founded.first;
  }
}
