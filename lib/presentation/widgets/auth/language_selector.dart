import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/settings_provider.dart';

class LanguageSelector extends ConsumerWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(settingsProvider).locale;

    return GestureDetector(
      onTap: () => _showLanguageSheet(context, ref, currentLocale),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.language, color: Colors.white70, size: 20),
            const SizedBox(width: 8),
            Text(
              _getLanguageName(currentLocale.languageCode),
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 4),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white54,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  void _showLanguageSheet(
    BuildContext context,
    WidgetRef ref,
    Locale currentLocale,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1E293B), // Dark background matching theme
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const Text(
                'Select Language',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    _buildLanguageItem(
                      context,
                      ref,
                      'tr',
                      'Türkçe',
                      currentLocale,
                    ),
                    _buildLanguageItem(
                      context,
                      ref,
                      'en',
                      'English',
                      currentLocale,
                    ),
                    _buildLanguageItem(
                      context,
                      ref,
                      'de',
                      'Deutsch',
                      currentLocale,
                    ),
                    _buildLanguageItem(
                      context,
                      ref,
                      'es',
                      'Español',
                      currentLocale,
                    ),
                    _buildLanguageItem(
                      context,
                      ref,
                      'fr',
                      'Français',
                      currentLocale,
                    ),
                    _buildLanguageItem(
                      context,
                      ref,
                      'it',
                      'Italiano',
                      currentLocale,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLanguageItem(
    BuildContext context,
    WidgetRef ref,
    String code,
    String name,
    Locale currentLocale,
  ) {
    final isSelected = currentLocale.languageCode == code;

    return InkWell(
      onTap: () {
        ref.read(settingsProvider.notifier).setLocale(Locale(code));
        Navigator.pop(context);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.white.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Text(
              name,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.white70,
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF4ECDC4), // Secondary color
                size: 20,
              ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'tr':
        return 'TR';
      case 'en':
        return 'EN';
      case 'de':
        return 'DE';
      case 'es':
        return 'ES';
      case 'fr':
        return 'FR';
      case 'it':
        return 'IT';
      default:
        return code.toUpperCase();
    }
  }
}
