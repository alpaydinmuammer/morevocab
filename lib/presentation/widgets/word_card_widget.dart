import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../domain/models/word_card.dart';
import '../../domain/models/word_deck.dart';
import '../../core/theme/app_theme.dart';
import '../../presentation/providers/settings_provider.dart';

class WordCardWidget extends ConsumerStatefulWidget {
  final WordCard wordCard;
  final VoidCallback? onSpeak;

  const WordCardWidget({super.key, required this.wordCard, this.onSpeak});

  @override
  ConsumerState<WordCardWidget> createState() => _WordCardWidgetState();
}

class _WordCardWidgetState extends ConsumerState<WordCardWidget>
    with SingleTickerProviderStateMixin {
  bool _showMeaning = false;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant WordCardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Reset flip state when card changes
    if (oldWidget.wordCard.id != widget.wordCard.id) {
      _showMeaning = false;
      _flipController.reset();
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _toggleCard() {
    if (_showMeaning) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() {
      _showMeaning = !_showMeaning;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: _toggleCard,
      child: ListenableBuilder(
        listenable: _flipAnimation,
        builder: (context, child) {
          final isBack = _flipAnimation.value > 0.5;
          final rotationValue = _flipAnimation.value * 3.14159;

          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(rotationValue),
            child: isBack ? _buildBackSide(theme) : _buildFrontSide(theme),
          );
        },
      ),
    );
  }

  Widget _buildFrontSide(ThemeData theme) {
    final hasImage =
        widget.wordCard.hasLocalAsset || widget.wordCard.imageUrl != null;
    final isStrategy = widget.wordCard.deck == WordDeck.examStrategies;

    return RepaintBoundary(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: hasImage
                ? [
                    AppTheme.primaryColor.withValues(alpha: 0.2),
                    AppTheme.secondaryColor,
                  ]
                : isStrategy
                ? [const Color(0xFF00ACC1), const Color(0xFF00838F)]
                : [AppTheme.primaryColor, AppTheme.secondaryColor],
          ),
          boxShadow: [
            BoxShadow(
              color:
                  (isStrategy ? const Color(0xFF00ACC1) : AppTheme.primaryColor)
                      .withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Stack(
            children: [
              // Background image - supports local assets and network images
              if (widget.wordCard.hasLocalAsset)
                Positioned.fill(
                  child: Image.asset(
                    widget.wordCard.localAsset!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stack) =>
                        Container(color: AppTheme.secondaryColor),
                  ),
                )
              else if (widget.wordCard.imageUrl != null)
                Positioned.fill(
                  child: CachedNetworkImage(
                    imageUrl: widget.wordCard.imageUrl!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      color: AppTheme.secondaryColor,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        Container(color: AppTheme.secondaryColor),
                  ),
                )
              else if (isStrategy)
                // Strategy card background decoration - glowing lightbulb
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Column(
                    children: [
                      // Glow effect behind icon
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withValues(alpha: 0.3),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.lightbulb_rounded,
                          size: 50,
                          color: Colors.white.withValues(alpha: 0.4),
                        ),
                      ),
                    ],
                  ),
                ),
              // Gradient overlay - stronger at bottom for text readability
              if (hasImage)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: const [0.0, 0.5, 0.75, 1.0],
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.5),
                          Colors.black.withValues(alpha: 0.85),
                        ],
                      ),
                    ),
                  ),
                ),
              // Content
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: isStrategy
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.end,
                  crossAxisAlignment: isStrategy
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  children: [
                    if (isStrategy) const Spacer(flex: 1),
                    // Word/Strategy title
                    if (isStrategy)
                      // Strategy: Display words line by line
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildStrategyLines(widget.wordCard.word, theme),
                      )
                    else
                      // Regular word: original layout
                      Row(
                        children: [
                          Expanded(
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.wordCard.word,
                                style: theme.textTheme.displaySmall?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.8,
                                      ),
                                      blurRadius: 8,
                                      offset: const Offset(0, 2),
                                    ),
                                    Shadow(
                                      color: Colors.black.withValues(
                                        alpha: 0.5,
                                      ),
                                      blurRadius: 16,
                                      offset: const Offset(0, 4),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (isStrategy) const Spacer(flex: 1),
                    if (!isStrategy) const SizedBox(height: 8),
                    // Tap to see meaning badge
                    if (isStrategy)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            AppLocalizations.of(context)!.tapToSeeMeaning,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: Colors.white.withValues(alpha: 0.9),
                            ),
                          ),
                        ),
                      )
                    else
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          AppLocalizations.of(context)!.tapToSeeMeaning,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ),
                    if (isStrategy) const SizedBox(height: 16),
                  ],
                ),
              ),
              // Difficulty indicator (hide for strategies)
              if (!isStrategy)
                Positioned(top: 16, right: 16, child: _buildDifficultyBadge()),
              // Speak button (hide for strategies)
              if (!isStrategy)
                Positioned(
                  top: 16,
                  left: 16,
                  child: ClipOval(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.25),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.1),
                            width: 1,
                          ),
                        ),
                        child: IconButton(
                          onPressed: widget.onSpeak,
                          icon: const Icon(Icons.volume_up_rounded),
                          color: Colors.white,
                          iconSize: 22,
                          constraints: const BoxConstraints(
                            minWidth: 40,
                            minHeight: 40,
                          ),
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  /// Build strategy lines - each word/phrase on its own line
  Widget _buildStrategyLines(String strategyText, ThemeData theme) {
    // Parse the strategy text by '/' separator
    final parts = strategyText
        .split('/')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    // Adjust font size based on number of lines
    double fontSize;
    if (parts.length <= 2) {
      fontSize = 36;
    } else if (parts.length <= 4) {
      fontSize = 32;
    } else if (parts.length <= 6) {
      fontSize = 28;
    } else if (parts.length <= 8) {
      fontSize = 26;
    } else {
      fontSize = 20;
    }

    // Prepositions to highlight
    final prepositions = [
      '+ ON',
      '+ FROM',
      '+ TO',
      '+ WITH',
      '+ INTO',
      '+ IN',
      '& ',
    ];

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: parts.map((part) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: _buildHighlightedText(part, fontSize, prepositions),
        );
      }).toList(),
    );
  }

  /// Build text with highlighted prepositions
  Widget _buildHighlightedText(
    String text,
    double fontSize,
    List<String> prepositions,
  ) {
    // Check if text contains any preposition to highlight
    String? foundPrep;
    for (final prep in prepositions) {
      if (text.contains(prep)) {
        foundPrep = prep;
        break;
      }
    }

    if (foundPrep == null) {
      // No preposition found, return simple text
      return Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: fontSize,
          height: 1.2,
          shadows: [
            Shadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        textAlign: TextAlign.center,
      );
    }

    // Split text and highlight preposition
    final parts = text.split(foundPrep);
    final normalStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      height: 1.2,
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 0.4),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    final highlightStyle = TextStyle(
      color: const Color(0xFFFFEB3B), // Yellow/gold for prepositions
      fontWeight: FontWeight.bold,
      fontSize: fontSize,
      height: 1.2,
      shadows: [
        Shadow(
          color: Colors.black.withValues(alpha: 0.5),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: parts[0], style: normalStyle),
          TextSpan(text: foundPrep, style: highlightStyle),
          if (parts.length > 1) TextSpan(text: parts[1], style: normalStyle),
        ],
      ),
    );
  }

  Widget _buildBackSide(ThemeData theme) {
    final isStrategy = widget.wordCard.deck == WordDeck.examStrategies;

    // Parse example sentences for strategies (split by ' / ')
    List<String> exampleSentences = [];
    if (widget.wordCard.exampleSentence != null) {
      if (isStrategy && widget.wordCard.exampleSentence!.contains(' / ')) {
        exampleSentences = widget.wordCard.exampleSentence!
            .split(' / ')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      } else {
        exampleSentences = [widget.wordCard.exampleSentence!];
      }
    }

    return RepaintBoundary(
      child: Transform(
        alignment: Alignment.center,
        transform: Matrix4.identity()..rotateY(3.14159),
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: theme.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Title
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    widget.wordCard.word,
                    style: theme.textTheme.headlineMedium?.copyWith(
                      color: isStrategy
                          ? const Color(0xFF00838F)
                          : AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: isStrategy ? 20 : null,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: 60,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isStrategy
                        ? const Color(0xFF00838F)
                        : AppTheme.secondaryColor,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                // Meaning/Description - smaller for strategies
                Text(
                  widget.wordCard.getMeaning(
                    ref.watch(settingsProvider).locale.languageCode,
                  ),
                  style: isStrategy
                      ? theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        )
                      : theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  textAlign: TextAlign.center,
                ),
                if (exampleSentences.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isStrategy
                            ? const Color(0xFF00838F).withValues(alpha: 0.1)
                            : AppTheme.primaryColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: isStrategy
                              ? const Color(0xFF00838F).withValues(alpha: 0.3)
                              : AppTheme.primaryColor.withValues(alpha: 0.2),
                          width: 1,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: isStrategy
                              ? CrossAxisAlignment.start
                              : CrossAxisAlignment.center,
                          children: [
                            if (isStrategy) ...[
                              // Strategy examples header
                              Row(
                                children: [
                                  Icon(
                                    Icons.format_list_bulleted_rounded,
                                    size: 18,
                                    color: const Color(0xFF00838F),
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    AppLocalizations.of(context)!.examples,
                                    style: theme.textTheme.labelLarge?.copyWith(
                                      color: const Color(0xFF00838F),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Bulleted examples
                              ...exampleSentences.map(
                                (sentence) => Padding(
                                  padding: const EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.only(top: 6),
                                        width: 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          color: const Color(0xFF00838F),
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Text(
                                          sentence,
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(height: 1.4),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ] else ...[
                              // Regular word: quote icon and centered text
                              Icon(
                                Icons.format_quote,
                                color: AppTheme.primaryColor.withValues(
                                  alpha: 0.3,
                                ),
                                size: 24,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                exampleSentences.first,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontStyle: FontStyle.italic,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                if (exampleSentences.isEmpty) const Spacer(),
                const SizedBox(height: 12),
                Text(
                  AppLocalizations.of(context)!.tapToReturn,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDifficultyBadge() {
    final difficulty = widget.wordCard.difficulty;
    final color = difficulty <= 2
        ? Colors.green
        : difficulty <= 3
        ? Colors.orange
        : Colors.red;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 8),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          return Icon(
            index < difficulty ? Icons.star : Icons.star_border,
            size: 14,
            color: index < difficulty ? color : Colors.grey.shade300,
          );
        }),
      ),
    );
  }
}
