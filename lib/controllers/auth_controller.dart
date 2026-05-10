import 'package:flutter/foundation.dart';
import '../config/app_config.dart';
import '../services/auth_storage.dart';

class AuthController extends ChangeNotifier {
  AuthController(this._storage);

  final AuthStorage _storage;

  static const _validEmail = AppConfig.authEmail;
  static const _validPassword = AppConfig.authPassword;

  bool _isAuthenticated = false;
  bool get isAuthenticated => _isAuthenticated;

  bool loading = false;
  String? errorMessage;

  Future<void> hydrate() async {
    final token = await _storage.read();
    _isAuthenticated = token != null;
  }

  Future<void> login(String email, String password) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    if (email != _validEmail || password != _validPassword) {
      loading = false;
      errorMessage = 'Invalid email or password';
      notifyListeners();
      return;
    }

    final token = 'dummy-${DateTime.now().millisecondsSinceEpoch}';
    await _storage.write(token);
    _isAuthenticated = true;
    loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await _storage.clear();
    _isAuthenticated = false;
    notifyListeners();
  }
}
