import 'package:flutter/foundation.dart';
import '../models/scheme_detail.dart';
import '../services/api_service.dart';

class SchemeDetailController extends ChangeNotifier {
  SchemeDetailController(this._api);

  final ApiService _api;

  SchemeDetail? detail;
  bool loading = false;
  String? errorMessage;

  Future<void> fetch(int schemeCode) async {
    // TODO: fetch scheme detail, set detail, notify
  }
}
