import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

/// Word deck categories for vocabulary learning
enum WordDeck {
  examStrategies,
  mixed,
  ydsYdt,
  beginner,
  survival,
  phrasalVerbs,
  idioms,
  custom, // User-created decks
}

extension WordDeckExtension on WordDeck {
  String getLocalizedName(BuildContext context) {
    switch (this) {
      case WordDeck.mixed:
        return AppLocalizations.of(context)!.deckMixed;
      case WordDeck.ydsYdt:
        return AppLocalizations.of(context)!.deckYdsYdt;
      case WordDeck.beginner:
        return AppLocalizations.of(context)!.deckBeginner;
      case WordDeck.survival:
        return AppLocalizations.of(context)!.deckSurvival;
      case WordDeck.phrasalVerbs:
        return AppLocalizations.of(context)!.deckPhrasalVerbs;
      case WordDeck.idioms:
        return AppLocalizations.of(context)!.deckIdioms;
      case WordDeck.examStrategies:
        return AppLocalizations.of(context)!.deckExamStrategies;
      case WordDeck.custom:
        return 'Custom Deck'; // Or localized 'Custom'
    }
  }

  String getLocalizedDescription(BuildContext context) {
    switch (this) {
      case WordDeck.mixed:
        return AppLocalizations.of(context)!.deckMixedDesc;
      case WordDeck.ydsYdt:
        return AppLocalizations.of(context)!.deckYdsYdtDesc;
      case WordDeck.beginner:
        return AppLocalizations.of(context)!.deckBeginnerDesc;
      case WordDeck.survival:
        return AppLocalizations.of(context)!.deckSurvivalDesc;
      case WordDeck.phrasalVerbs:
        return AppLocalizations.of(context)!.deckPhrasalVerbsDesc;
      case WordDeck.idioms:
        return AppLocalizations.of(context)!.deckIdiomsDesc;
      case WordDeck.examStrategies:
        return AppLocalizations.of(context)!.deckExamStrategiesDesc;
      case WordDeck.custom:
        return 'Your personal collection';
    }
  }

  String get displayName {
    switch (this) {
      case WordDeck.mixed:
        return 'Karışık';
      case WordDeck.ydsYdt:
        return 'YDS/YDT Words';
      case WordDeck.beginner:
        return 'Beginner Words';
      case WordDeck.survival:
        return 'Survival English';
      case WordDeck.phrasalVerbs:
        return 'Phrasal Verbs';
      case WordDeck.idioms:
        return 'Idioms & Slang';
      case WordDeck.examStrategies:
        return 'Sınav Stratejileri';
      case WordDeck.custom:
        return 'Kendi Desten';
    }
  }

  String get description {
    switch (this) {
      case WordDeck.mixed:
        return 'Tüm kelimelerden karışık';
      case WordDeck.ydsYdt:
        return 'Akademik sınav kelimeleri';
      case WordDeck.beginner:
        return 'Başlangıç seviyesi';
      case WordDeck.survival:
        return 'Günlük hayat ve seyahat';
      case WordDeck.phrasalVerbs:
        return 'Yaygın phrasal verb\'ler';
      case WordDeck.idioms:
        return 'Deyimler ve argo ifadeler';
      case WordDeck.examStrategies:
        return 'Sınav taktikleri ve ipuçları';
      case WordDeck.custom:
        return 'Kendi eklediğin kelimeler';
    }
  }

  IconData get icon {
    switch (this) {
      case WordDeck.mixed:
        return Icons.shuffle_rounded;
      case WordDeck.ydsYdt:
        return Icons.school_rounded;
      case WordDeck.beginner:
        return Icons.child_care_rounded;
      case WordDeck.survival:
        return Icons.flight_takeoff_rounded;
      case WordDeck.phrasalVerbs:
        return Icons.link_rounded;
      case WordDeck.idioms:
        return Icons.chat_bubble_rounded;
      case WordDeck.examStrategies:
        return Icons.lightbulb_outline_rounded;
      case WordDeck.custom:
        return Icons.edit_note_rounded;
    }
  }

  Color get color {
    switch (this) {
      case WordDeck.mixed:
        return Colors.indigo;
      case WordDeck.ydsYdt:
        return Colors.deepPurple;
      case WordDeck.beginner:
        return Colors.green;
      case WordDeck.survival:
        return Colors.orange;
      case WordDeck.phrasalVerbs:
        return Colors.teal;
      case WordDeck.idioms:
        return Colors.pink;
      case WordDeck.examStrategies:
        return Colors.cyan;
      case WordDeck.custom:
        return Colors.blueGrey;
    }
  }

  /// Path to the deck's logo image
  String? get imagePath {
    switch (this) {
      case WordDeck.examStrategies:
        return 'assets/images/decks/exam_strategies.png';
      case WordDeck.mixed:
        return 'assets/images/decks/mixed.png';
      case WordDeck.ydsYdt:
        return 'assets/images/decks/yds_ydt.png';
      case WordDeck.beginner:
        return 'assets/images/decks/beginner.png';
      case WordDeck.survival:
        return 'assets/images/decks/survival.png';
      case WordDeck.phrasalVerbs:
        return 'assets/images/decks/phrasal_verbs.png';
      case WordDeck.idioms:
        return 'assets/images/decks/idioms.png';
      case WordDeck.custom:
        return null; // No image for custom decks
    }
  }
}
