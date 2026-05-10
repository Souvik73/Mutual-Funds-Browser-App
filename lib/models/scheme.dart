class Scheme {
  const Scheme({required this.schemeCode, required this.schemeName});

  final int schemeCode;
  final String schemeName;

  factory Scheme.fromJson(Map<String, dynamic> json) => Scheme(
        schemeCode: json['schemeCode'] as int,
        schemeName: json['schemeName'] as String,
      );
}
