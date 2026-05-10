import 'nav_entry.dart';

class SchemeDetail {
  const SchemeDetail({
    required this.name,
    required this.fundHouse,
    required this.category,
    required this.history,
  });

  final String name;
  final String fundHouse;
  final String category;
  final List<NavEntry> history;
}
