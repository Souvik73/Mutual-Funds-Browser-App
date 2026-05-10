import 'package:dio/dio.dart';
import '../models/scheme.dart';
import '../models/scheme_detail.dart';
import '../models/nav_entry.dart';
import '../errors/api_exception.dart';

class ApiService {
  const ApiService(this._dio);

  final Dio _dio;

  Future<List<Scheme>> getSchemes() async {
    // TODO: implement with cache options
    throw UnimplementedError();
  }

  Future<SchemeDetail> getSchemeDetail(int schemeCode) async {
    // TODO: implement with cache options
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
        throw ServerException(
          e.response?.statusCode ?? 0,
          'Server error',
        );
      default:
        throw const NetworkException('Something went wrong');
    }
  }
}
