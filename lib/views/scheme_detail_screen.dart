import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/scheme_detail_controller.dart';
import '../models/scheme_detail.dart';
import 'widgets/error_view.dart';
import 'widgets/nav_history_row.dart';
import 'widgets/nav_history_skeleton.dart';
import 'widgets/invest_bottom_sheet.dart';

class SchemeDetailScreen extends StatefulWidget {
  const SchemeDetailScreen({super.key, required this.schemeCode});

  final int schemeCode;

  @override
  State<SchemeDetailScreen> createState() => _SchemeDetailScreenState();
}

class _SchemeDetailScreenState extends State<SchemeDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<SchemeDetailController>().fetch(widget.schemeCode),
    );
  }

  void _showInvestSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => InvestBottomSheet(
        onSuccess: () => ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Investment placed successfully'),
            behavior: SnackBarBehavior.floating,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ctrl = context.watch<SchemeDetailController>();
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: cs.surfaceContainerLow,
      appBar: AppBar(
        backgroundColor: cs.primary,
        foregroundColor: cs.onPrimary,
        elevation: 0,
        title: Text(
          ctrl.detail?.name ?? 'Scheme Detail',
          style: TextStyle(
            color: cs.onPrimary,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      bottomNavigationBar: ctrl.detail != null
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: FilledButton(
                  onPressed: _showInvestSheet,
                  style: FilledButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Invest'),
                ),
              ),
            )
          : null,
      body: _body(ctrl, cs),
    );
  }

  Widget _body(SchemeDetailController ctrl, ColorScheme cs) {
    if (ctrl.loading) return const NavHistorySkeleton();

    if (ctrl.errorMessage != null) {
      return ErrorView(
        message: ctrl.errorMessage!,
        onRetry: () =>
            context.read<SchemeDetailController>().fetch(widget.schemeCode),
      );
    }

    final detail = ctrl.detail;
    if (detail == null) return const SizedBox.shrink();

    return Column(
      children: [
        _HeaderStrip(detail: detail),
        Expanded(child: _NavList(detail: detail)),
      ],
    );
  }
}

class _HeaderStrip extends StatelessWidget {
  const _HeaderStrip({required this.detail});

  final SchemeDetail detail;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            detail.fundHouse,
            style: tt.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            detail.category,
            style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}

class _ColumnHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final style = tt.bodySmall?.copyWith(
      fontWeight: FontWeight.w600,
      color: cs.onSurfaceVariant,
    );

    return Container(
      color: cs.surfaceContainerLow,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Date', style: style),
          Text('NAV Value', style: style),
        ],
      ),
    );
  }
}

class _NavList extends StatelessWidget {
  const _NavList({required this.detail});

  final SchemeDetail detail;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: detail.history.isEmpty
          ? Center(
              child: Text(
                'No NAV history available',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: cs.onSurfaceVariant),
              ),
            )
          : Column(
              children: [
                _ColumnHeader(),
                Divider(height: 1, color: cs.surfaceContainerLow),
                Expanded(
                  child: ListView.separated(
                    itemCount: detail.history.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: cs.surfaceContainerLow,
                    ),
                    itemBuilder: (context, index) =>
                        NavHistoryRow(entry: detail.history[index]),
                  ),
                ),
              ],
            ),
    );
  }
}
