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

  factory SchemeDetail.fromJson(Map<String, dynamic> json) {
    final meta = json['meta'] as Map<String, dynamic>;
    return SchemeDetail(
      name: meta['scheme_name'] as String,
      fundHouse: meta['fund_house'] as String,
      category: meta['scheme_category'] as String,
      history: (json['data'] as List)
          .map((e) => NavEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
