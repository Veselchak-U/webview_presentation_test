import 'dart:async';

import 'package:dio/dio.dart';
import 'package:presentation_test/core/logger/logger.dart';

typedef ResponseConverter<T> = T Function(dynamic response);

class DioClient {
  String baseUrl = 'http://192.168.100.17:3001/';

  String? _token;
  late Dio _dio;

  DioClient() {
    _dio = _createDio();
  }

  Dio get dio => _dio;

  Dio _createDio() => Dio(
        BaseOptions(
          baseUrl: baseUrl,
          headers: {
            'Content-Type': 'application/json; charset=utf-8',
            'Accept': 'application/json',
            'ForceUseSession': 'true',
            if (_token != null) ...{
              'BPMCSRF': _token,
            },
          },
          receiveTimeout: const Duration(seconds: 30),
          connectTimeout: const Duration(seconds: 30),
          validateStatus: (int? status) {
            return status! > 0;
          },
        ),
      );

  Future<void> downloadRequest(
    String url,
    String savePath, {
    ProgressCallback? onReceiveProgress,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    int attemptsCount = 0,
  }) async {
    // final isInternetAvailable = await ConnectivityHelper.isInternetAvailable();
    // if (!isInternetAvailable) {
    //   return throw DioException(
    //     requestOptions: RequestOptions(),
    //     type: DioExceptionType.connectionTimeout,
    //     error: 'No internet connection',
    //   );
    // }
    final response = await dio.download(
      url,
      savePath,
      onReceiveProgress: onReceiveProgress,
      cancelToken: cancelToken,
      deleteOnError: deleteOnError,
      options: Options(
        receiveTimeout: const Duration(minutes: 60),
      ),
    );
    log.d(response);
    if (response.statusCode == 401) {
      if (attemptsCount > 3) {
        throw DioException(
          requestOptions: response.requestOptions,
          response: response,
          error: 'Request attempts exceeded',
        );
      }
      return downloadRequest(
        url,
        savePath,
        onReceiveProgress: onReceiveProgress,
        cancelToken: cancelToken,
        deleteOnError: deleteOnError,
        attemptsCount: attemptsCount + 1,
      );
    }
    if ((response.statusCode ?? 0) < 200 || (response.statusCode ?? 0) > 201) {
      throw DioException(
        requestOptions: response.requestOptions,
        response: response,
      );
    }
  }
}
