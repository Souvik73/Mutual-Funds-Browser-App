import 'package:intl/intl.dart';

final _apiFormat = DateFormat('dd-MM-yyyy');
final _displayFormat = DateFormat('dd MMM yyyy');

DateTime parseApiDate(String raw) => _apiFormat.parseStrict(raw);

String formatDisplayDate(DateTime date) => _displayFormat.format(date);
