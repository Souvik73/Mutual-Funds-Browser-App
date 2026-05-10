import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';

class DioClient {
  DioClient._();

  static Dio create(HiveCacheStore store) {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.mfapi.in',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    dio.interceptors.add(
      DioCacheInterceptor(
        options: CacheOptions(
          store: store,
          policy: CachePolicy.refreshForceCache,
          hitCacheOnErrorExcept: [401, 403],
        ),
      ),
    );
    return dio;
  }
}
