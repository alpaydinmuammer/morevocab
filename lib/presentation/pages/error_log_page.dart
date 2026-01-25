import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../l10n/app_localizations.dart';
import '../providers/error_log_provider.dart';
import '../widgets/premium_background.dart';

/// Notebook-style page showing all error log entries
class ErrorLogPage extends ConsumerStatefulWidget {
  const ErrorLogPage({super.key});

  @override
  ConsumerState<ErrorLogPage> createState() => _ErrorLogPageState();
}

class _ErrorLogPageState extends ConsumerState<ErrorLogPage> {
  static const int _itemsPerPage = 12;
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final errorLogState = ref.watch(errorLogProvider);

    final entries = errorLogState.entries;
    final totalPages = (entries.length / _itemsPerPage).ceil();
    final startIndex = _currentPage * _itemsPerPage;
    final endIndex = (startIndex + _itemsPerPage).clamp(0, entries.length);
    final pageEntries = entries.isEmpty
        ? <dynamic>[]
        : entries.sublist(startIndex, endIndex);

    return Scaffold(
      body: PremiumBackground(
        showTypo: false,
        child: SafeArea(
          child: Column(
            children: [
              // Header
              _buildHeader(context, theme, l10n),

              // Notebook content
              Expanded(
                child: entries.isEmpty
                    ? _buildEmptyState(theme, l10n)
                    : _buildNotebook(theme, l10n, pageEntries, totalPages),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(
    BuildContext context,
    ThemeData theme,
    AppLocalizations l10n,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest.withValues(
                alpha: 0.5,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_rounded),
              onPressed: () => context.pop(),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.errorLogTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.red.shade700,
                  ),
                ),
                Text(
                  l10n.errorLogSubtitle,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme, AppLocalizations l10n) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.check_circle_outline_rounded,
            size: 80,
            color: Colors.green.withValues(alpha: 0.5),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.errorLogEmpty,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.errorLogEmptyHint,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotebook(
    ThemeData theme,
    AppLocalizations l10n,
    List<dynamic> pageEntries,
    int totalPages,
  ) {
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Notebook pages
        Expanded(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF2A2520) : const Color(0xFFFFFBF0),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(
                color: isDark ? Colors.brown.shade800 : Colors.brown.shade200,
                width: 2,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Stack(
                children: [
                  // Lined paper effect
                  CustomPaint(
                    size: Size.infinite,
                    painter: _LinedPaperPainter(isDark: isDark),
                  ),

                  // Red margin line
                  Positioned(
                    left: 40,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: 2,
                      color: Colors.red.withValues(alpha: 0.3),
                    ),
                  ),

                  // Entries list
                  ListView.builder(
                    padding: const EdgeInsets.fromLTRB(50, 16, 16, 16),
                    itemCount: pageEntries.length,
                    itemBuilder: (context, index) {
                      final entry = pageEntries[index];
                      return _buildEntryRow(theme, entry, isDark);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),

        // Page navigation
        if (totalPages > 1) _buildPageNavigation(theme, l10n, totalPages),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildEntryRow(ThemeData theme, dynamic entry, bool isDark) {
    final xMarks = '❌' * entry.wrongCount;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // X marks
          Text(xMarks, style: const TextStyle(fontSize: 14)),
          const SizedBox(width: 8),
          // Word and translation
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.word,
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  entry.translation,
                  style: TextStyle(
                    fontFamily: 'Caveat',
                    fontSize: 16,
                    color: isDark ? Colors.white70 : Colors.black54,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageNavigation(
    ThemeData theme,
    AppLocalizations l10n,
    int totalPages,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: _currentPage > 0
                ? () => setState(() => _currentPage--)
                : null,
            icon: const Icon(Icons.chevron_left_rounded),
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
          const SizedBox(width: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              l10n.errorLogPage(_currentPage + 1, totalPages),
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(width: 16),
          IconButton(
            onPressed: _currentPage < totalPages - 1
                ? () => setState(() => _currentPage++)
                : null,
            icon: const Icon(Icons.chevron_right_rounded),
            style: IconButton.styleFrom(
              backgroundColor: theme.colorScheme.surfaceContainerHighest,
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom painter for lined paper effect
class _LinedPaperPainter extends CustomPainter {
  final bool isDark;

  _LinedPaperPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = isDark
          ? Colors.brown.withValues(alpha: 0.2)
          : Colors.blue.withValues(alpha: 0.1)
      ..strokeWidth = 1;

    const lineSpacing = 32.0;
    var y = lineSpacing;

    while (y < size.height) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
      y += lineSpacing;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
