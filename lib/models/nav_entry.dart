class NavEntry {
  const NavEntry({required this.date, required this.nav});

  final DateTime date;
  final double nav;

  factory NavEntry.fromJson(Map<String, dynamic> json) => NavEntry(
        date: _parseDate(json['date'] as String),
        nav: double.parse(json['nav'] as String),
      );

  static DateTime _parseDate(String raw) {
    final parts = raw.split('-');
    return DateTime(
      int.parse(parts[2]),
      int.parse(parts[1]),
      int.parse(parts[0]),
    );
  }
}
