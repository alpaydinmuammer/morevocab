import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'l10n/app_localizations.dart';

import 'core/theme/app_theme.dart';
import 'core/constants/app_constants.dart';
import 'core/router/app_router.dart';
import 'core/services/cloud_image_service.dart';
import 'core/services/sound_service.dart';
import 'presentation/providers/settings_provider.dart';
import 'firebase_options.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import dotenv

// ...

void main() async {
  // Preserve native splash until Flutter is ready
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // Load environment variables
  await dotenv.load(fileName: ".env");

  // Initialize Firebase BEFORE router (required for auth state stream)
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Cloud Image Service for CDN caching
  await CloudImageService().initialize();

  // Initialize Sound Service
  await SoundService().initialize();

  // Remove native splash - Firebase is ready
  // Notifications will be initialized lazily in SplashPage for faster startup
  FlutterNativeSplash.remove();

  runApp(const ProviderScope(child: MoreVocabApp()));
}

class MoreVocabApp extends ConsumerWidget {
  const MoreVocabApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: settings.themeMode,
      locale: settings.locale,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
    );
  }
}
