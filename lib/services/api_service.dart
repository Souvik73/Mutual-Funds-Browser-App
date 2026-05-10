import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import '../models/scheme.dart';
import '../models/scheme_detail.dart';
import '../errors/api_exception.dart';

class ApiService {
  ApiService(this._dio, this._store);

  final Dio _dio;
  final HiveCacheStore _store;

  static const _noErrorFallback = [401, 403];

  Options get _listOpts => CacheOptions(
        store: _store,
        policy: CachePolicy.request,
        maxStale: const Duration(hours: 1),
        hitCacheOnErrorExcept: _noErrorFallback,
      ).toOptions();

  Options get _detailOpts => CacheOptions(
        store: _store,
        policy: CachePolicy.request,
        maxStale: const Duration(minutes: 15),
        hitCacheOnErrorExcept: _noErrorFallback,
      ).toOptions();

  Future<List<Scheme>> getSchemes() async {
    try {
      final res = await _dio.get('/mf', options: _listOpts);
      return (res.data as List)
          .map((e) => Scheme.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      _handleDioError(e);
    } on FormatException {
      throw const ParseException('Failed to parse scheme list');
    }
  }

  Future<SchemeDetail> getSchemeDetail(int schemeCode) async {
    // TODO: implement
    throw UnimplementedError();
  }

  Never _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        throw const NetworkException('No internet connection');
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        throw const NetworkException('Request timed out');
      case DioExceptionType.badResponse:
        throw ServerException(e.response?.statusCode ?? 0, 'Server error');
      default:
        throw const NetworkException('Something went wrong');
    }
  }
}
