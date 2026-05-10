import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/auth_controller.dart';
import '../controllers/scheme_list_controller.dart';
import 'widgets/error_view.dart';
import 'widgets/scheme_list_skeleton.dart';
import 'widgets/scheme_list_tile.dart';

class SchemeListScreen extends StatefulWidget {
  const SchemeListScreen({super.key});

  @override
  State<SchemeListScreen> createState() => _SchemeListScreenState();
}

class _SchemeListScreenState extends State<SchemeListScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<SchemeListController>().fetch(),
    );
  }

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
      body: const Column(
        children: [
          _SearchBar(),
          Expanded(child: _SchemeList()),
        ],
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar();

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
    final ctrl = context.watch<SchemeListController>();
    final cs = Theme.of(context).colorScheme;

    if (ctrl.errorMessage != null) {
      return ErrorView(
        message: ctrl.errorMessage!,
        onRetry: () => context.read<SchemeListController>().fetch(),
      );
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 4, 16, 16),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: ctrl.loading
          ? const SchemeListSkeleton()
          : ctrl.filteredSchemes.isEmpty
              ? Center(
                  child: Text(
                    'No schemes found',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: cs.onSurfaceVariant),
                  ),
                )
              : ListView.separated(
                  itemCount: ctrl.filteredSchemes.length,
                  separatorBuilder: (_, __) => Divider(
                    height: 1,
                    indent: 72,
                    color: cs.surfaceContainerLow,
                  ),
                  itemBuilder: (context, index) {
                    final scheme = ctrl.filteredSchemes[index];
                    return SchemeListTile(
                      scheme: scheme,
                      onTap: () {}, // TODO: context.go('/scheme/${scheme.schemeCode}')
                    );
                  },
                ),
    );
  }
}
