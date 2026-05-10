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

class _SchemeList extends StatefulWidget {
  const _SchemeList();

  @override
  State<_SchemeList> createState() => _SchemeListState();
}

class _SchemeListState extends State<_SchemeList> {
  final _scrollCtrl = ScrollController();
  bool _showBackToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollCtrl.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollCtrl.dispose();
    super.dispose();
  }

  void _onScroll() {
    final pixels = _scrollCtrl.position.pixels;

    final shouldShow = pixels > 300;
    if (shouldShow != _showBackToTop) {
      setState(() => _showBackToTop = shouldShow);
    }

    if (pixels >= _scrollCtrl.position.maxScrollExtent - 200) {
      context.read<SchemeListController>().loadMore();
    }
  }

  void _scrollToTop() {
    _scrollCtrl.animateTo(
      0,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

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

    return Stack(
      children: [
        Positioned.fill(
          child: Container(
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
                    : Scrollbar(
                        controller: _scrollCtrl,
                        thumbVisibility: true,
                        child: ListView.separated(
                          controller: _scrollCtrl,
                          itemCount: ctrl.displayedSchemes.length +
                              (ctrl.hasMore ? 1 : 0),
                          separatorBuilder: (_, index) {
                            if (ctrl.hasMore &&
                                index == ctrl.displayedSchemes.length - 1) {
                              return const SizedBox.shrink();
                            }
                            return Divider(
                              height: 1,
                              indent: 72,
                              color: cs.surfaceContainerLow,
                            );
                          },
                          itemBuilder: (context, index) {
                            if (ctrl.hasMore &&
                                index == ctrl.displayedSchemes.length) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: cs.primary,
                                    ),
                                  ),
                                ),
                              );
                            }
                            final scheme = ctrl.displayedSchemes[index];
                            return SchemeListTile(
                              scheme: scheme,
                              onTap: () {}, // TODO: context.go('/scheme/${scheme.schemeCode}')
                            );
                          },
                        ),
                      ),
          ),
        ),
        if (_showBackToTop && !ctrl.loading && ctrl.filteredSchemes.isNotEmpty)
          Positioned(
            right: 24,
            bottom: 24,
            child: FloatingActionButton.small(
              onPressed: _scrollToTop,
              backgroundColor: cs.primary,
              foregroundColor: cs.onPrimary,
              child: const Icon(Icons.keyboard_arrow_up_rounded),
            ),
          ),
      ],
    );
  }
}
