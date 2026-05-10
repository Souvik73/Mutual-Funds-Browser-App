import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'app.dart';
import 'controllers/auth_controller.dart';
import 'services/api_service.dart';
import 'services/auth_storage.dart';
import 'services/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: await Hive.initFlutter() + build HiveCacheStore; pass to DioClient.create()
  final dio = DioClient.create();
  final apiService = ApiService(dio);
  final authController = AuthController(
    AuthStorage(const FlutterSecureStorage()),
  );

  await authController.hydrate();

  runApp(App(authController: authController, apiService: apiService));
}
