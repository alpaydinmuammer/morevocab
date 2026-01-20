import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/word_deck.dart';
import '../../domain/models/word_card.dart';
import '../../data/services/vocab_generation_service.dart';
import '../widgets/premium_background.dart';
import '../../l10n/app_localizations.dart';
import '../providers/word_providers.dart';

class CustomDeckPage extends ConsumerStatefulWidget {
  final String deckName;

  const CustomDeckPage({super.key, required this.deckName});

  @override
  ConsumerState<CustomDeckPage> createState() => _CustomDeckPageState();
}

class _CustomDeckPageState extends ConsumerState<CustomDeckPage> {
  List<WordCard> _words = [];
  bool _isLoading = true;
  final VocabGenerationService _generationService = VocabGenerationService();

  @override
  void initState() {
    super.initState();
    _loadWords();
  }

  Future<void> _loadWords() async {
    final repository = ref.read(wordRepositoryProvider);
    final result = await repository.getWordsByDeck(WordDeck.custom);

    result.when(
      success: (allCustomWords) {
        setState(() {
          _words = allCustomWords
              .where((w) => w.customDeckName == widget.deckName)
              .toList();
          _isLoading = false;
        });
      },
      failure: (_) {
        setState(() {
          _words = [];
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _deleteWord(int id) async {
    final repository = ref.read(wordRepositoryProvider);
    await repository.deleteCustomWord(id);
    _loadWords();
  }

  Future<void> _addNewWord(String word) async {
    // Show loading
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (c) => const Center(child: CircularProgressIndicator()),
    );

    try {
      // 1. Generate text content
      final content = await _generationService.generateWordContent(word);
      if (content == null) {
        if (mounted) {
          Navigator.pop(context); // Close loading
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                AppLocalizations.of(context)!.failedToGenerate,
              ),
            ),
          );
        }
        return;
      }

      // 2. Generate Image URL (or use fallback)
      final imageUrl = await _generationService.generateImageUrl(
        content['image_prompt'] ?? word,
      );

      // 3. Create WordCard
      final newCard = WordCard(
        id: DateTime.now().millisecondsSinceEpoch, // Simple ID generation
        word: word,
        meanings: {
          'en': content['meaning_en'] ?? '',
          'tr': content['meaning_tr'] ?? '',
        },
        exampleSentence: content['example'],
        imageUrl: imageUrl,
        deck: WordDeck.custom,
        customDeckName: widget.deckName,
        difficulty: 1, // Default
      );

      // 4. Save
      final repository = ref.read(wordRepositoryProvider);
      await repository.saveCustomWord(newCard);

      if (mounted) {
        Navigator.pop(context); // Close loading
        Navigator.pop(context); // Close Add Dialog
        _loadWords(); // Refresh list
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.wordAdded(word, widget.deckName))),
        );
      }
    } catch (e) {
      if (mounted) {
        Navigator.pop(context);
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(l10n.errorOccurred('$e'))));
      }
    }
  }

  void _showAddWordDialog() {
    final controller = TextEditingController();
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.addNewWord),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(l10n.enterWordPrompt),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: l10n.wordExample,
                border: const OutlineInputBorder(),
              ),
              autofocus: true,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              final text = controller.text.trim();
              if (text.isNotEmpty) {
                _addNewWord(text);
              }
            },
            child: Text(l10n.generateAndAdd),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.deckName),
        leading: const BackButton(color: Colors.white),
      ),
      body: PremiumBackground(
        child: SafeArea(
          child: _words.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.library_add,
                        size: 64,
                        color: Colors.white54,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        l10n.noWordsYet,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.white),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l10n.tapToAddWords,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _words.length,
                  itemBuilder: (context, index) {
                    final word = _words[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.white.withValues(alpha: 0.1),
                      child: ListTile(
                        leading: word.imageUrl != null
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  word.imageUrl!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                  errorBuilder: (c, o, s) => const Icon(
                                    Icons.broken_image,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : const Icon(Icons.image, color: Colors.white),
                        title: Text(
                          word.word,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          word.getMeaning('tr'),
                          style: TextStyle(
                            color: Colors.white.withValues(alpha: 0.7),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.redAccent,
                          ),
                          onPressed: () => _deleteWord(word.id),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddWordDialog,
        icon: const Icon(Icons.auto_awesome),
        label: Text(l10n.addWord),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      ),
    );
  }
}
