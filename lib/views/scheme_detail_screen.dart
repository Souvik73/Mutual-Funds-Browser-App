import 'package:flutter/material.dart';

class SchemeDetailScreen extends StatefulWidget {
  const SchemeDetailScreen({super.key, required this.schemeCode});

  final int schemeCode;

  @override
  State<SchemeDetailScreen> createState() => _SchemeDetailScreenState();
}

class _SchemeDetailScreenState extends State<SchemeDetailScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement header strip + NAV history list / skeleton / error + Invest button
    return const Scaffold(body: Placeholder());
  }
}
