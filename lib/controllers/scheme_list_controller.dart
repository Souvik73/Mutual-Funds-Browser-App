import 'package:flutter/foundation.dart';
import '../models/scheme.dart';
import '../services/api_service.dart';
import '../errors/api_exception.dart';

class SchemeListController extends ChangeNotifier {
  SchemeListController(this._api);

  final ApiService _api;

  static const _pageSize = 50;

  List<Scheme> _allSchemes = [];
  List<Scheme> filteredSchemes = [];
  int _displayCount = _pageSize;
  bool loading = false;
  String? errorMessage;

  List<Scheme> get displayedSchemes =>
      filteredSchemes.take(_displayCount).toList();

  bool get hasMore => _displayCount < filteredSchemes.length;

  Future<void> fetch() async {
    loading = true;
    errorMessage = null;
    notifyListeners();

    try {
      _allSchemes = await _api.getSchemes();
      filteredSchemes = List.of(_allSchemes);
      _displayCount = _pageSize;
    } on AppException catch (e) {
      errorMessage = e.message;
    } catch (_) {
      errorMessage = 'Something went wrong';
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  void loadMore() {
    if (!hasMore) return;
    _displayCount = (_displayCount + _pageSize).clamp(0, filteredSchemes.length);
    notifyListeners();
  }

  void filter(String query) {
    _displayCount = _pageSize;
    if (query.isEmpty) {
      filteredSchemes = List.of(_allSchemes);
    } else {
      final q = query.toLowerCase();
      filteredSchemes = _allSchemes
          .where((s) =>
              s.schemeName.toLowerCase().contains(q) ||
              s.schemeCode.toString().contains(q))
          .toList();
    }
    notifyListeners();
  }
}
