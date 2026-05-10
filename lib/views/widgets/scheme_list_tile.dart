import 'package:flutter/material.dart';
import '../../models/scheme.dart';

class SchemeListTile extends StatelessWidget {
  const SchemeListTile({super.key, required this.scheme, required this.onTap});

  final Scheme scheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      title: Text(
        scheme.schemeName,
        style: tt.bodyLarge,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 4),
        child: Text(
          'Code: ${scheme.schemeCode}',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: cs.outlineVariant),
      onTap: onTap,
    );
  }
}
