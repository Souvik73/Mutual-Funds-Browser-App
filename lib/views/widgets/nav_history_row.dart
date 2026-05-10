import 'package:flutter/material.dart';
import '../../models/nav_entry.dart';
import '../../utils/date_format.dart';

class NavHistoryRow extends StatelessWidget {
  const NavHistoryRow({super.key, required this.entry});

  final NavEntry entry;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            formatDisplayDate(entry.date),
            style: tt.bodyMedium,
          ),
          Text(
            '₹ ${entry.nav.toStringAsFixed(4)}',
            style: tt.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: cs.primary,
            ),
          ),
        ],
      ),
    );
  }
}
