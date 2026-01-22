import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/models/pet_model.dart';
import '../../../l10n/app_localizations.dart';
import '../../../core/constants/app_constants.dart';
import '../../providers/pet_provider.dart';

/// Modal for selecting a pet type and giving it a name
class PetSelectionModal extends ConsumerStatefulWidget {
  const PetSelectionModal({super.key});

  static Future<bool?> show(BuildContext context) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const PetSelectionModal(),
    );
  }

  @override
  ConsumerState<PetSelectionModal> createState() => _PetSelectionModalState();
}

class _PetSelectionModalState extends ConsumerState<PetSelectionModal> {
  PetType? _selectedType;
  final _nameController = TextEditingController();
  bool _isCreating = false;
  int _currentStep = 0; // 0: select pet, 1: name pet

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _createPet() async {
    if (_selectedType == null || _nameController.text.trim().isEmpty) return;

    setState(() => _isCreating = true);

    final success = await ref
        .read(petProvider.notifier)
        .createPet(name: _nameController.text.trim(), type: _selectedType!);

    if (mounted) {
      setState(() => _isCreating = false);
      if (success) {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      margin: EdgeInsets.only(bottom: bottomPadding),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SafeArea(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: _currentStep == 0 ? _buildPetSelection() : _buildNameInput(),
        ),
      ),
    );
  }

  Widget _buildPetSelection() {
    final theme = Theme.of(context);

    return Padding(
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
          const SizedBox(height: 24),

          // Title
          Text(
            AppLocalizations.of(context)!.petSelectTitle,
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            AppLocalizations.of(context)!.petSelectSubtitle,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 32),

          // Pet options
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.1,
            children: PetType.values.map((type) {
              final isSelected = _selectedType == type;
              return _PetOptionCard(
                type: type,
                isSelected: isSelected,
                onTap: () => setState(() => _selectedType = type),
              );
            }).toList(),
          ),
          const SizedBox(height: 32),

          // Continue button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _selectedType != null
                  ? () => setState(() => _currentStep = 1)
                  : null,
              child: Text(
                AppLocalizations.of(context)!.petContinue,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNameInput() {
    final theme = Theme.of(context);

    return Padding(
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
          const SizedBox(height: 24),

          // Back button and title
          Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _currentStep = 0),
                icon: const Icon(Icons.arrow_back),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  AppLocalizations.of(context)!.petNameTitle,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),

          // Selected pet preview
          if (_selectedType != null) ...[
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipOval(
                child: Image.asset(
                  _selectedType!.getImagePath(PetStage.baby),
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      width: 100,
                      height: 100,
                      color: theme.colorScheme.primaryContainer,
                      child: Center(
                        child: Text(
                          _selectedType!.emoji,
                          style: const TextStyle(fontSize: AppConstants.petEmojiSizeLarge),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _selectedType!.getLocalizedName(context),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 24),
          ],

          // Name input
          TextField(
            controller: _nameController,
            autofocus: true,
            textCapitalization: TextCapitalization.words,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.petNameHint,
              filled: true,
              fillColor: theme.colorScheme.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(Icons.pets),
            ),
            onSubmitted: (_) => _createPet(),
          ),
          const SizedBox(height: 32),

          // Create button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _isCreating ? null : _createPet,
              child: _isCreating
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      AppLocalizations.of(context)!.petLetsStart,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Card widget for a single pet option
class _PetOptionCard extends StatelessWidget {
  final PetType type;
  final bool isSelected;
  final VoidCallback onTap;

  const _PetOptionCard({
    required this.type,
    required this.isSelected,
    required this.onTap,
  });

  String _getDescription(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (type) {
      case PetType.dragon:
        return l10n.petDragonDesc;
      case PetType.eagle:
        return l10n.petEagleDesc;
      case PetType.wolf:
        return l10n.petWolfDesc;
      case PetType.fox:
        return l10n.petFoxDesc;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? theme.colorScheme.primary : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Pet image
            ClipOval(
              child: Image.asset(
                type.getImagePath(PetStage.baby),
                width: 56,
                height: 56,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Text(type.emoji, style: const TextStyle(fontSize: AppConstants.petSelectionEmojiSize));
                },
              ),
            ),
            const SizedBox(height: 8),
            // Name
            Text(
              type.getLocalizedName(context),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 4),
            // Description
            Text(
              _getDescription(context),
              style: theme.textTheme.bodySmall?.copyWith(
                color: isSelected
                    ? theme.colorScheme.onPrimaryContainer.withValues(
                        alpha: 0.8,
                      )
                    : theme.colorScheme.onSurfaceVariant,
              ),
            ),
            // Checkmark
            if (isSelected) ...[
              const SizedBox(height: 8),
              Icon(
                Icons.check_circle,
                color: theme.colorScheme.primary,
                size: 20,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
