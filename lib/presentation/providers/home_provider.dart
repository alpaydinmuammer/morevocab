import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/constants/time_constants.dart';
import '../../l10n/app_localizations.dart';

class HomeState {
  final String Function(AppLocalizations) getGreeting;
  final String Function(AppLocalizations) getMotivationalPhrase;

  const HomeState({
    required this.getGreeting,
    required this.getMotivationalPhrase,
  });
}

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier()
    : super(
        HomeState(getGreeting: (_) => '', getMotivationalPhrase: (_) => ''),
      ) {
    _updateState();
  }

  void _updateState() {
    state = HomeState(
      getGreeting: _calculateGreeting,
      getMotivationalPhrase: _calculateMotivationalPhrase,
    );
  }

  String _calculateGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour >= TimeConstants.morningStartHour &&
        hour < TimeConstants.morningEndHour) {
      return l10n.goodMorning;
    } else if (hour >= TimeConstants.afternoonStartHour &&
        hour < TimeConstants.afternoonEndHour) {
      return l10n.goodAfternoon;
    } else if (hour >= TimeConstants.eveningStartHour &&
        hour < TimeConstants.eveningEndHour) {
      return l10n.goodEvening;
    } else {
      return l10n.goodNight;
    }
  }

  String _calculateMotivationalPhrase(AppLocalizations l10n) {
    final now = DateTime.now();
    final hour = now.hour;
    final weekday = now.weekday;

    // Special message for 02:00-02:59 on Monday, Thursday, Sunday
    if (hour == TimeConstants.specialMotivationalHour &&
        (weekday == DateTime.monday ||
            weekday == DateTime.thursday ||
            weekday == DateTime.sunday)) {
      return l10n.motive2am;
    }

    // Special message for 03:00-04:59 (late night)
    if (hour >= TimeConstants.lateNightStartHour &&
        hour < TimeConstants.lateNightEndHour) {
      return l10n.motiveLateNight;
    }

    // Day-based phrases
    switch (weekday) {
      case DateTime.monday:
        return l10n.motiveMon;
      case DateTime.tuesday:
        return l10n.motiveTue;
      case DateTime.wednesday:
        return l10n.motiveWed;
      case DateTime.thursday:
        return l10n.motiveThu;
      case DateTime.friday:
        return l10n.motiveFri;
      case DateTime.saturday:
        return l10n.motiveSat;
      case DateTime.sunday:
        return l10n.motiveSun;
      default:
        return l10n.letsLearn;
    }
  }

  /// Refreshes the greeting/motive (e.g., when app resumes)
  void refresh() {
    _updateState();
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier();
});
