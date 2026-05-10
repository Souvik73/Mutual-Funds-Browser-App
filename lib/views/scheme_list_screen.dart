import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../models/scheme.dart';
import 'widgets/scheme_list_tile.dart';

class SchemeListScreen extends StatelessWidget {
  const SchemeListScreen({super.key});

  static const _mockSchemes = [
    Scheme(schemeCode: 100033, schemeName: 'Aditya Birla Sun Life Frontline Equity Fund - Growth'),
    Scheme(schemeCode: 119598, schemeName: 'HDFC Mid-Cap Opportunities Fund - Regular Growth'),
    Scheme(schemeCode: 120503, schemeName: 'SBI Bluechip Fund - Regular Growth'),
    Scheme(schemeCode: 118989, schemeName: 'Axis Long Term Equity Fund - Growth'),
    Scheme(schemeCode: 112090, schemeName: 'Mirae Asset Large Cap Fund - Regular Growth'),
    Scheme(schemeCode: 125354, schemeName: 'Nippon India Small Cap Fund - Growth'),
    Scheme(schemeCode: 100425, schemeName: 'Franklin India Prima Fund - Growth'),
    Scheme(schemeCode: 130503, schemeName: 'Parag Parikh Flexi Cap Fund - Regular Growth'),
    Scheme(schemeCode: 119247, schemeName: 'Kotak Emerging Equity Fund - Regular Growth'),
    Scheme(schemeCode: 135781, schemeName: 'UTI Nifty 50 Index Fund - Regular Growth'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 0,
        title: Text(
          'Mutual Funds',
          style: TextStyle(
            color: cs.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            tooltip: 'Logout',
            onPressed: () => context.read<AuthController>().logout(),
          ),
        ],
      ),
      body: Column(
        children: [
          _SearchBar(),
          const Expanded(child: _SchemeList()),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search schemes...',
          hintStyle: TextStyle(color: cs.onSurfaceVariant),
          prefixIcon: Icon(Icons.search_rounded, color: cs.onSurfaceVariant),
          filled: true,
          fillColor: cs.surface,
          contentPadding: const EdgeInsets.symmetric(vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: cs.primary, width: 1.5),
          ),
          // TODO: wire onChanged → SchemeListController.filter()
        ),
      ),
    );
  }
}

class _SchemeList extends StatelessWidget {
  const _SchemeList();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: ListView.separated(
        itemCount: SchemeListScreen._mockSchemes.length,
        separatorBuilder: (_, __) => Divider(
          height: 1,
          indent: 72,
          color: cs.surfaceContainerLow,
        ),
        itemBuilder: (context, index) {
          final scheme = SchemeListScreen._mockSchemes[index];
          return SchemeListTile(
            scheme: scheme,
            onTap: () {}, // TODO: context.go('/scheme/${scheme.schemeCode}')
          );
        },
      ),
    );
  }
}
