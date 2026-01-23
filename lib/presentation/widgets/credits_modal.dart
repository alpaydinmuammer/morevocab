import 'dart:ui' as importing_dart_ui;
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../l10n/app_localizations.dart';
import 'premium_background.dart';

class CreditsModal extends StatelessWidget {
  const CreditsModal({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Define a "brand" color for the credits section
    final Color creditColor = Colors.indigo;

    // A height constraint is needed to prevent it from being full screen
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: PremiumBackground(
          showTypo: false,
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
                        color: theme.colorScheme.onSurface.withValues(
                          alpha: 0.1,
                        ),
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
                    padding: const EdgeInsets.fromLTRB(24, 40, 24, 20),
                    child: Row(
                      children: [
                        // Header Icon
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: creditColor.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: creditColor.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: creditColor.withValues(alpha: 0.2),
                                blurRadius: 16,
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.verified_user_rounded,
                            color: creditColor,
                            size: 32,
                          ),
                        ),
                        const SizedBox(width: 20),
                        // Title & Subtitle
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppLocalizations.of(context)!.credits,
                                style: theme.textTheme.headlineSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  height: 1.1,
                                  color: isDark
                                      ? Colors.white
                                      : theme.colorScheme.onSurface,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'More Vocab Team',
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
                child: ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  children: [
                    _buildCreditCard(
                      context,
                      title: AppLocalizations.of(context)!.creditsDevelopment,
                      name: 'Muammer Alpaydın',
                      icon: Icons.code_rounded,
                      color: Colors.blue,
                    ),
                    const SizedBox(height: 12),
                    _buildCreditCard(
                      context,
                      title: AppLocalizations.of(context)!.creditsDesign,
                      name: 'Muammer Alpaydın',
                      icon: Icons.auto_awesome_rounded,
                      color: Colors.purple,
                    ),
                    const SizedBox(height: 12),
                    _buildCreditCard(
                      context,
                      title: AppLocalizations.of(context)!.creditsTechnology,
                      name: 'Flutter & Dart',
                      icon: Icons.bolt_rounded,
                      color: Colors.cyan,
                    ),
                    const SizedBox(height: 12),
                    _buildCreditCard(
                      context,
                      title: AppLocalizations.of(context)!.creditsVersion,
                      name: '1.0.0',
                      icon: Icons.info_outline_rounded,
                      color: Colors.teal,
                    ),
                    const SizedBox(height: 32),

                    // Contact Button
                    _buildContactButton(context),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactButton(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => _sendEmail(context),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: LinearGradient(
            colors: [Colors.indigo.shade600, Colors.blue.shade600],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.indigo.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Background decoration
            Positioned(
              right: -10,
              bottom: -10,
              child: Icon(
                Icons.mark_email_unread_rounded,
                size: 80,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),

            // Content
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.mail_rounded, color: Colors.white, size: 24),
                const SizedBox(width: 12),
                Text(
                  AppLocalizations.of(context)!.contactUs.toUpperCase(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _sendEmail(BuildContext context) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'alpaydinmuammer@gmail.com',
      query: _encodeQueryParameters(<String, String>{
        'subject': 'More Vocab Feedback',
      }),
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri, mode: LaunchMode.externalApplication);
      } else {
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email app')),
        );
      }
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map(
          (MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}',
        )
        .join('&');
  }

  Widget _buildCreditCard(
    BuildContext context, {
    required String title,
    required String name,
    required IconData icon,
    required Color color,
  }) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Use similar card colors to deck modal
    final Color cardColor = isDark
        ? const Color(0xFF1E1E2C).withValues(alpha: 0.5)
        : theme.cardTheme.color!.withValues(alpha: 0.7);

    final Color borderColor = theme.dividerColor.withValues(alpha: 0.1);
    final Color textColor = theme.colorScheme.onSurface;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: isDark
              ? (importing_dart_ui.ImageFilter.blur(sigmaX: 10, sigmaY: 10))
              : (importing_dart_ui.ImageFilter.blur(sigmaX: 0, sigmaY: 0)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: textColor.withValues(alpha: 0.6),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        name,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: textColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
