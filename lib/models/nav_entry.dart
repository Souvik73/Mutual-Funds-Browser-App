import 'package:mutual_fund_browser/utils/date_format.dart';

class NavEntry {
  const NavEntry({required this.date, required this.nav});

  final DateTime date;
  final double nav;

  factory NavEntry.fromJson(Map<String, dynamic> json) => NavEntry(
        date: parseApiDate(json['date'] as String),
        nav: double.parse(json['nav'] as String),
      );

}
