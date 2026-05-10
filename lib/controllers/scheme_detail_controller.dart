import 'package:flutter/foundation.dart';
import '../models/scheme_detail.dart';
import '../services/api_service.dart';
import '../errors/api_exception.dart';

class SchemeDetailController extends ChangeNotifier {
  SchemeDetailController(this._api);

  final ApiService _api;

  SchemeDetail? detail;
  bool loading = false;
  String? errorMessage;

  Future<void> fetch(int schemeCode) async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      detail = await _api.getSchemeDetail(schemeCode);
    } on AppException catch (e) {
      errorMessage = e.message;
    } catch (_) {
      errorMessage = 'Something went wrong';
    } finally {
      loading = false;
      notifyListeners();
    }
  }
}
