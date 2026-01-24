import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/challenge_model.dart';
import '../../l10n/app_localizations.dart';
import '../providers/arcade_provider.dart';
import '../providers/challenge_provider.dart';

/// Modal showing daily challenges
class ChallengesModal extends ConsumerWidget {
  const ChallengesModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ChallengesModal(),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final challengesState = ref.watch(challengesProvider);

    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle
              Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outlineVariant,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 20),

              // Header
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.orange.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.local_fire_department_rounded,
                      color: Colors.orange,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.dailyChallenges,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${challengesState.completedCount}/${challengesState.challenges.length} ${l10n.completed}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Challenges list
              if (challengesState.isLoading)
                const Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                )
              else
                ...challengesState.challenges.map(
                  (challenge) => _ChallengeCard(challenge: challenge),
                ),

              const SizedBox(height: 16),

              // Close button
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(l10n.ok),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  final Challenge challenge;

  const _ChallengeCard({required this.challenge});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: challenge.isCompleted
            ? Colors.green.withValues(alpha: 0.1)
            : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
        border: challenge.isCompleted
            ? Border.all(color: Colors.green.withValues(alpha: 0.3))
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // Game logo
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _getGameColor(
                    challenge.gameType,
                  ).withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    _getGameImage(challenge.gameType),
                    width: 36,
                    height: 36,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Challenge description
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _getChallengeTitle(context, challenge, l10n),
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        decoration: challenge.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: challenge.isCompleted
                            ? theme.colorScheme.onSurfaceVariant
                            : null,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _getGameName(context, challenge.gameType, l10n),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),

              // XP reward or checkmark
              if (challenge.isCompleted)
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                )
              else
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.amber.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '+${challenge.xpReward} XP',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.amber.shade700,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),

          // Progress bar (only if not completed)
          if (!challenge.isCompleted) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: challenge.progressPercent,
                      minHeight: 6,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(
                        _getGameColor(challenge.gameType),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  '${challenge.currentProgress}/${challenge.targetValue}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  String _getChallengeTitle(
    BuildContext context,
    Challenge challenge,
    AppLocalizations l10n,
  ) {
    switch (challenge.type) {
      case ChallengeType.scoreInGame:
        return l10n.challengeScore(challenge.targetValue);
      case ChallengeType.reachLevel:
        return l10n.challengeLevel(challenge.targetValue);
      case ChallengeType.playAnyGame:
        return l10n.challengePlayGame;
    }
  }

  String _getGameName(
    BuildContext context,
    ArcadeGameType? game,
    AppLocalizations l10n,
  ) {
    if (game == null) return l10n.anyGame;
    switch (game) {
      case ArcadeGameType.wordChain:
        return l10n.gameWordChain;
      case ArcadeGameType.anagram:
        return l10n.gameAnagram;
      case ArcadeGameType.wordBuilder:
        return l10n.gameWordBuilder;
      case ArcadeGameType.emojiPuzzle:
        return l10n.gameEmojiPuzzle;
      case ArcadeGameType.oddOneOut:
        return l10n.gameOddOneOut;
    }
  }

  String _getGameImage(ArcadeGameType? game) {
    if (game == null) return 'assets/images/arcade/word_chain.png';
    switch (game) {
      case ArcadeGameType.wordChain:
        return 'assets/images/arcade/word_chain.png';
      case ArcadeGameType.anagram:
        return 'assets/images/arcade/anagram.png';
      case ArcadeGameType.wordBuilder:
        return 'assets/images/arcade/word_builder.png';
      case ArcadeGameType.emojiPuzzle:
        return 'assets/images/arcade/emoji_puzzle.png';
      case ArcadeGameType.oddOneOut:
        return 'assets/images/arcade/odd_one_out.png';
    }
  }

  Color _getGameColor(ArcadeGameType? game) {
    if (game == null) return Colors.purple;
    switch (game) {
      case ArcadeGameType.wordChain:
        return Colors.blue;
      case ArcadeGameType.anagram:
        return Colors.purple;
      case ArcadeGameType.wordBuilder:
        return Colors.teal;
      case ArcadeGameType.emojiPuzzle:
        return Colors.pink;
      case ArcadeGameType.oddOneOut:
        return Colors.orange;
    }
  }
}
