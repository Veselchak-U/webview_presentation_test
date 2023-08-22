abstract class FileService {
  Future<String> getAppDocumentsDirectoryPath();

  Future<bool> fileExist(String path);

  Future<bool> directoryExist(String path);

  Future<void> deleteFile(String path);

  Future<void> deleteDirectory(String path);

  Future<void> createDirectory(String path);

  Future<List<String>> findFile(String fileName, String startPath);

  Future<void> extractZipFile({
    required String filePath,
    required String destinationPath,
    void Function(double)? onExtracting,
  });

  Future<void> extractAllZips({
    required String dirPath,
    void Function(double)? onExtracting,
  });
}
