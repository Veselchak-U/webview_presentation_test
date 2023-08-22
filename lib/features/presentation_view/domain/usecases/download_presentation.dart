import 'package:presentation_test/core/api/dio_client.dart';

class DownloadPresentation {
  final DioClient _dioClient;

  DownloadPresentation(this._dioClient);

  Future<void> download(
    String url,
    String filePath, {
    void Function(int, int)? onReceiveProgress,
  }) async {
    // _cancelToken = CancelToken();
    await _dioClient.downloadRequest(
      url,
      filePath,
      onReceiveProgress: onReceiveProgress,
      // cancelToken: _cancelToken,
    );
    // _cancelToken = null;
  }
}
