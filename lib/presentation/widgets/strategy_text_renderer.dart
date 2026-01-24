import 'package:flutter/material.dart';

class StrategyTextRenderer extends StatelessWidget {
  final String text;
  final ThemeData theme;

  const StrategyTextRenderer({
    super.key,
    required this.text,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    return _buildStrategyLines(text);
  }

  /// Build strategy lines - each word/phrase on its own line
  Widget _buildStrategyLines(String strategyText) {
    // Parse the strategy text by '/' separator
    final parts = strategyText
        .split('/')
        .map((s) => s.trim())
        .where((s) => s.isNotEmpty)
        .toList();

    // Adjust font size based on number of lines
    double fontSize;
    if (parts.length <= 2) {
      fontSize = 38;
    } else if (parts.length <= 4) {
      fontSize = 32;
    } else if (parts.length <= 6) {
      fontSize = 28;
    } else if (parts.length <= 8) {
      fontSize = 24;
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
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: parts.map((part) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: _buildHighlightedText(part, fontSize, prepositions),
          ),
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

    // Highlighter colors for prepositions
    final highlighterColor = const Color(0xFFFDFD96).withValues(alpha: 0.8);
    final inkColor = const Color(0xFF2C3E50); // Dark ink blue/grey

    if (foundPrep == null) {
      return Text(
        text,
        style: TextStyle(
          color: inkColor,
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
          height: 1.4,
        ),
        textAlign: TextAlign.center,
      );
    }

    // Split text and highlight preposition
    final parts = text.split(foundPrep);
    final normalStyle = TextStyle(
      color: inkColor,
      fontWeight: FontWeight.w600,
      fontSize: fontSize,
      height: 1.4,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        children: [
          TextSpan(text: parts[0], style: normalStyle),
          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: highlighterColor,
                borderRadius: BorderRadius.circular(2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.yellow.withValues(alpha: 0.2),
                    blurRadius: 4,
                    spreadRadius: 1,
                  ),
                ],
              ),
              child: Text(
                foundPrep,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: fontSize,
                ),
              ),
            ),
          ),
          if (parts.length > 1) TextSpan(text: parts[1], style: normalStyle),
        ],
      ),
    );
  }
}
