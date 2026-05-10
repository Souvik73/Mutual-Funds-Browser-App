abstract class AppException implements Exception {
  const AppException(this.message);
  final String message;
  @override
  String toString() => message;
}

class NetworkException extends AppException {
  const NetworkException(super.message);
}

class ServerException extends AppException {
  const ServerException(this.statusCode, super.message);
  final int statusCode;
}

class ParseException extends AppException {
  const ParseException(super.message);
}
