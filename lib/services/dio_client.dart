import 'package:dio/dio.dart';

class DioClient {
  DioClient._();

  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.mfapi.in',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    // TODO: add DioCacheInterceptor with HiveCacheStore
    return dio;
  }
}
