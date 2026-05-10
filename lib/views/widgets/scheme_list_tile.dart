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
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      leading: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: cs.primaryContainer,
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        child: Text(
          scheme.schemeName[0],
          style: TextStyle(
            color: cs.onPrimaryContainer,
            fontWeight: FontWeight.w700,
            fontSize: 17,
          ),
        ),
      ),
      title: Text(
        scheme.schemeName,
        style: tt.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: Text(
          'Code  ${scheme.schemeCode}',
          style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
        ),
      ),
      trailing: Icon(Icons.chevron_right_rounded, color: cs.outlineVariant),
      onTap: onTap,
    );
  }
}
