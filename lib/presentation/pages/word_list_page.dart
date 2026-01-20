import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/word_card.dart';
import '../../domain/repositories/word_repository.dart';
import '../providers/word_providers.dart';
import '../../l10n/app_localizations.dart';

enum WordListType {
  total,
  unknown,
  learning,
  mastered;

  String getTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (this) {
      case WordListType.total:
        return l10n.allWords;
      case WordListType.unknown:
        return l10n.unknownWords;
      case WordListType.learning:
        return l10n.learningWords;
      case WordListType.mastered:
        return l10n.masteredWords;
    }
  }
}

class WordListPage extends ConsumerWidget {
  final WordListType type;

  const WordListPage({super.key, required this.type});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repository = ref.watch(wordRepositoryProvider);
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(type.getTitle(context)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: FutureBuilder<List<WordCard>>(
        future: _fetchWords(repository),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(l10n.errorOccurred('${snapshot.error}')));
          }

          final words = snapshot.data ?? [];

          if (words.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 64,
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.noWordsInDeck,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: words.length,
            separatorBuilder: (context, index) => const SizedBox(height: 12),
            itemBuilder: (context, index) {
              final word = words[index];
              return _buildWordCard(context, word);
            },
          );
        },
      ),
    );
  }

  Future<List<WordCard>> _fetchWords(WordRepository repository) async {
    final result = await (switch (type) {
      WordListType.total => repository.getAllWords(),
      WordListType.unknown => repository.getUnknownWords(),
      WordListType.learning => repository.getLearningWords(),
      WordListType.mastered => repository.getMasteredWords(),
    });

    return result.when(
      success: (words) => words,
      failure: (error) => throw Exception(error),
    );
  }

  Widget _buildWordCard(BuildContext context, WordCard word) {
    final theme = Theme.of(context);

    Color statusColor;
    if (word.isMastered) {
      statusColor = Colors.green;
    } else if (word.srsLevel > 0) {
      statusColor = Colors.orange;
    } else {
      statusColor = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
        ),
      ),
      child: Row(
        children: [
          // Word Image or Placeholder
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              image: word.hasLocalAsset
                  ? DecorationImage(
                      image: AssetImage(word.localAsset!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: !word.hasLocalAsset
                ? Icon(Icons.image_not_supported_rounded, color: statusColor)
                : null,
          ),
          const SizedBox(width: 16),

          // Word Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  word.word,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  word.getMeaning('tr'), // Default to Turkish for now
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
