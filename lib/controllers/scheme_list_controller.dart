import 'package:flutter/foundation.dart';
import '../models/scheme.dart';
import '../services/api_service.dart';

class SchemeListController extends ChangeNotifier {
  SchemeListController(this._api);

  final ApiService _api;

  List<Scheme> _allSchemes = [];
  List<Scheme> filteredSchemes = [];
  bool loading = false;
  String? errorMessage;

  Future<void> fetch() async {
    // TODO: fetch all schemes, populate _allSchemes + filteredSchemes
  }

  void filter(String query) {
    // TODO: filter _allSchemes by query, update filteredSchemes, notify
  }
}
