import 'package:flutter/foundation.dart';
import '../models/scheme.dart';
import '../services/api_service.dart';
import '../errors/api_exception.dart';

class SchemeListController extends ChangeNotifier {
  SchemeListController(this._api);

  final ApiService _api;

  List<Scheme> _allSchemes = [];
  List<Scheme> filteredSchemes = [];
  bool loading = false;
  String? errorMessage;

  Future<void> fetch() async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _allSchemes = await _api.getSchemes();
      filteredSchemes = List.of(_allSchemes);
    } on AppException catch (e) {
      errorMessage = e.message;
    } catch (_) {
      errorMessage = 'Something went wrong';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void filter(String query) {
    if (query.isEmpty) {
      filteredSchemes = List.of(_allSchemes);
    } else {
      final q = query.toLowerCase();
      filteredSchemes = _allSchemes
          .where((s) => s.schemeName.toLowerCase().contains(q))
          .toList();
    }
    notifyListeners();
  }
}
