import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:dio_cache_interceptor_hive_store/dio_cache_interceptor_hive_store.dart';
import 'package:path_provider/path_provider.dart';
import 'app.dart';
import 'controllers/auth_controller.dart';
import 'services/api_service.dart';
import 'services/auth_storage.dart';
import 'services/dio_client.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  final dir = await getApplicationDocumentsDirectory();
  final store = HiveCacheStore(dir.path);

  final dio = DioClient.create(store);
  final apiService = ApiService(dio, store);
  final authController = AuthController(
    AuthStorage(const FlutterSecureStorage()),
  );

  // Reads token before runApp so the router has synchronous auth state — no flash of the wrong screen.
  await authController.hydrate();

  runApp(App(authController: authController, apiService: apiService));
}
