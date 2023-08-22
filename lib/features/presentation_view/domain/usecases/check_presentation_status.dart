import 'package:presentation_test/features/presentation_view/domain/entities/presentation_status.dart';
import 'package:presentation_test/features/presentation_view/domain/services/file_service.dart';

class CheckPresentationStatus {
  final FileService _fileService;

  CheckPresentationStatus(this._fileService);

  Future<PresentationStatus> checkStatus(
    String filePath,
    String dirPath,
  ) async {
    var currentStatus = const PresentationStatus.notLoaded();
    try {
      if (!await _fileService.fileExist(filePath)) {
        return currentStatus;
      }

      currentStatus = const PresentationStatus.loaded();
      if (!await _fileService.directoryExist(dirPath)) {
        return currentStatus;
      }

      currentStatus = const PresentationStatus.unpacked();
      final entryPoint = await findEntryPoint('index.html', dirPath);
      if (entryPoint.isEmpty) {
        return currentStatus;
      }

      return PresentationStatus.ready(entryPoint);
    } catch (error) {
      return PresentationStatus.error('$error', lastStatus: currentStatus);
    }
  }

  Future<String> findEntryPoint(String fileName, String dirPath) async {
    final founded = await _fileService.findFile(fileName, dirPath);
    return founded.isEmpty ? '' : founded.first;
  }
}
