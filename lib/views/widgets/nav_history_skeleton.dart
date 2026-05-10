import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class NavHistorySkeleton extends StatelessWidget {
  const NavHistorySkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Header strip skeleton
        Shimmer.fromColors(
          baseColor: Colors.grey.shade200,
          highlightColor: Colors.grey.shade50,
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(height: 14, width: 200, color: Colors.white),
                const SizedBox(height: 8),
                Container(height: 12, width: 140, color: Colors.white),
              ],
            ),
          ),
        ),
        // NAV rows skeleton
        Expanded(
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            decoration: BoxDecoration(
              color: cs.surface,
              borderRadius: BorderRadius.circular(12),
            ),
            clipBehavior: Clip.antiAlias,
            child: Shimmer.fromColors(
              baseColor: Colors.grey.shade200,
              highlightColor: Colors.grey.shade50,
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 10,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (_, __) => const _SkeletonRow(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SkeletonRow extends StatelessWidget {
  const _SkeletonRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(height: 14, width: 100, color: Colors.white),
          Container(height: 14, width: 80, color: Colors.white),
        ],
      ),
    );
  }
}
