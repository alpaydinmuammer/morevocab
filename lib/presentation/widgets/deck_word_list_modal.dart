import 'dart:ui' as importing_dart_ui;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/word_card.dart';
import '../../domain/models/word_deck.dart';
import '../../l10n/app_localizations.dart';
import '../providers/settings_provider.dart';
import '../providers/word_providers.dart';
import 'premium_background.dart';

class DeckWordListModal extends ConsumerWidget {
  final WordDeck deck;

  const DeckWordListModal({super.key, required this.deck});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final langCode = ref.watch(settingsProvider).locale.languageCode;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: PremiumBackground(
        showTypo: false, // Too noisy for a list modal
        showMesh: true,
        showGrain: true,
        child: Column(
          children: [
            // Header Section
            Stack(
              children: [
                // Handle bar
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),

                // Close Button (Top Right)
                Positioned(
                  right: 16,
                  top: 16,
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surfaceContainerHighest
                            .withValues(alpha: 0.3),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.1,
                          ),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.close_rounded,
                        size: 20,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ),

                // Content
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 32, 20, 16),
                  child: Row(
                    children: [
                      // Deck Logo
                      Container(
                        width: 56,
                        height: 56,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: deck.color.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: deck.color.withValues(alpha: 0.3),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: deck.color.withValues(alpha: 0.2),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                        child: deck.imagePath != null
                            ? Image.asset(deck.imagePath!, fit: BoxFit.contain)
                            : Icon(deck.icon, color: deck.color, size: 32),
                      ),
                      const SizedBox(width: 20),
                      // Title & Subtitle
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              deck.getLocalizedName(context),
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                                height: 1.1,
                                color: isDark
                                    ? Colors.white
                                    : theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              deck.getLocalizedDescription(context),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: isDark
                                    ? Colors.white.withValues(alpha: 0.7)
                                    : theme.colorScheme.onSurface.withValues(
                                        alpha: 0.6,
                                      ),
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: 1, color: Colors.white10),

            // List Content
            Expanded(
              child: FutureBuilder<List<WordCard>>(
                future: ref
                    .read(wordRepositoryProvider)
                    .getWordsByDeck(deck)
                    .then(
                      (result) => result.when(
                        success: (words) => words,
                        failure: (error) => throw Exception(error),
                      ),
                    ),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final words = snapshot.data ?? [];

                  if (words.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.feed_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurface.withValues(
                              alpha: 0.2,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.noWordsInDeck,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurface.withValues(
                                alpha: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    itemCount: words.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8),
                    itemBuilder: (context, index) {
                      final word = words[index];
                      final isKnown = word.srsLevel > 0;

                      // Theme Integration Colors
                      final Color cardColor = isKnown
                          ? (isDark
                                ? const Color(0xFF1B3B2F).withValues(
                                    alpha: 0.5,
                                  ) // Dark Green Tint
                                : Colors.green.shade50)
                          : theme.cardTheme.color!.withValues(
                              alpha: 0.7,
                            ); // Semi-transparent dark surface

                      final Color borderColor = isKnown
                          ? (isDark
                                ? Colors.green.withValues(alpha: 0.5)
                                : Colors.green.shade200)
                          : theme.dividerColor.withValues(alpha: 0.1);

                      final Color textColor = isKnown
                          ? (isDark ? Colors.white : Colors.green.shade900)
                          : theme.colorScheme.onSurface;

                      final Color iconColor = isKnown
                          ? const Color(0xFF4CAF50) // Success Green
                          : theme.colorScheme.onSurface.withValues(alpha: 0.3);

                      return Container(
                        decoration: BoxDecoration(
                          color: cardColor,
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // More rounded for premium feel
                          border: Border.all(
                            color: borderColor,
                            width: isKnown
                                ? 1.5
                                : 1, // Subtle border difference
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: BackdropFilter(
                            filter: isDark
                                ? (importing_dart_ui.ImageFilter.blur(
                                    sigmaX: 10,
                                    sigmaY: 10,
                                  ))
                                : (importing_dart_ui.ImageFilter.blur(
                                    sigmaX: 0,
                                    sigmaY: 0,
                                  )), // Blur only for dark glassmorphism
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          word.word,
                                          style: theme.textTheme.titleMedium
                                              ?.copyWith(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                color: textColor,
                                              ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          word.getMeaning(langCode),
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                color: isDark
                                                    ? Colors.white.withValues(
                                                        alpha: 0.6,
                                                      )
                                                    : theme
                                                          .colorScheme
                                                          .onSurface
                                                          .withValues(
                                                            alpha: 0.7,
                                                          ),
                                                height: 1.4,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  // Status Checkbox/Icon
                                  Container(
                                    margin: const EdgeInsets.only(top: 4),
                                    child: isKnown
                                        ? Container(
                                            padding: const EdgeInsets.all(4),
                                            decoration: const BoxDecoration(
                                              color: Color(
                                                0xFF4CAF50,
                                              ), // Solid Green Circle
                                              shape: BoxShape.circle,
                                            ),
                                            child: const Icon(
                                              Icons.check,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          )
                                        : Icon(
                                            Icons
                                                .circle_outlined, // Empty circle for unknown/todo
                                            color: iconColor,
                                            size: 24,
                                          ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Workaround for ImageFilter
