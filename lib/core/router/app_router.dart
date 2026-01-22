import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/word_deck.dart';
import '../../domain/models/auth_state.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/word_swipe_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/word_list_page.dart';
import '../../presentation/pages/deck_selection_page.dart';
import '../../presentation/pages/auth_page.dart';
import '../../presentation/pages/onboarding_page.dart';
import '../../presentation/providers/auth_provider.dart';
import '../../presentation/providers/settings_provider.dart';
import 'page_transitions.dart';

/// Provider for the GoRouter with auth redirect
final appRouterProvider = Provider<GoRouter>((ref) {
  // Use ref.read in redirect to avoid rebuilding router on every state change
  // The refreshListenable will trigger re-evaluation of redirect

  return GoRouter(
    initialLocation: '/splash',
    refreshListenable: GoRouterRefreshStream(ref),
    redirect: (context, state) {
      final isOnSplash = state.matchedLocation == '/splash';
      final isOnAuth = state.matchedLocation == '/auth';
      final isOnOnboarding = state.matchedLocation == '/onboarding';

      // Let splash handle its own navigation
      if (isOnSplash) return null;

      // Read current state (not watch - we don't want to rebuild router)
      final authState = ref.read(authStateProvider);
      final isGuest = ref.read(guestModeProvider);
      final settings = ref.read(settingsProvider);

      // Check auth state
      final isAuthenticated =
          authState.whenData((state) {
            return state is AuthAuthenticated;
          }).valueOrNull ??
          false;

      final isLoading = authState.isLoading;

      // Don't redirect while loading
      if (isLoading) return null;

      // User can access app if authenticated OR in guest mode
      final canAccess = isAuthenticated || isGuest;

      // Not authenticated/guest and not on auth/onboarding -> go to auth
      if (!canAccess && !isOnAuth && !isOnOnboarding) {
        return '/auth';
      }

      // Check onboarding state
      final hasSeenOnboarding = settings.hasSeenOnboarding;

      // Authenticated but hasn't seen onboarding -> show onboarding
      if (canAccess && !hasSeenOnboarding && !isOnOnboarding && !isOnAuth) {
        return '/onboarding';
      }

      // Has seen onboarding and on auth page -> go to home
      if (canAccess && hasSeenOnboarding && isOnAuth) {
        return '/';
      }

      // Has seen onboarding and on onboarding page -> go to home
      if (canAccess && hasSeenOnboarding && isOnOnboarding) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/splash',
        name: 'splash',
        pageBuilder: (context, state) => fadeTransition(
          key: state.pageKey,
          child: const SplashPage(),
          duration: const Duration(milliseconds: 600),
        ),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        pageBuilder: (context, state) => fadeTransition(
          key: state.pageKey,
          child: const AuthPage(),
          duration: const Duration(milliseconds: 400),
        ),
      ),
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        pageBuilder: (context, state) => fadeTransition(
          key: state.pageKey,
          child: const OnboardingPage(),
          duration: const Duration(milliseconds: 400),
        ),
      ),
      GoRoute(
        path: '/',
        name: 'home',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const HomePage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Premium circular reveal transition: Smooth circular expansion
            final curve = CurvedAnimation(
              parent: animation,
              curve: Curves.easeInOutQuad,
            );

            return AnimatedBuilder(
              animation: curve,
              builder: (context, child) {
                return ClipPath(
                  clipper: CircularRevealClipper(fraction: curve.value),
                  child: FadeTransition(
                    opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: const Interval(0.1, 1.0, curve: Curves.easeOut),
                      ),
                    ),
                    child: child,
                  ),
                );
              },
              child: child,
            );
          },
          transitionDuration: const Duration(
            milliseconds: 900,
          ), // Smooth circular reveal transition
        ),
      ),
      GoRoute(
        path: '/decks',
        name: 'decks',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const DeckSelectionPage(),
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/swipe',
        name: 'swipe',
        pageBuilder: (context, state) {
          final deck = state.extra as WordDeck? ?? WordDeck.mixed;
          return CustomTransitionPage(
            key: state.pageKey,
            child: WordSwipePage(deck: deck),
            transitionDuration: const Duration(milliseconds: 450),
            reverseTransitionDuration: const Duration(milliseconds: 450),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return CupertinoPageTransition(
                    primaryRouteAnimation: animation,
                    secondaryRouteAnimation: secondaryAnimation,
                    linearTransition: false,
                    child: child,
                  );
                },
          );
        },
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        pageBuilder: (context, state) => CustomTransitionPage(
          key: state.pageKey,
          child: const SettingsPage(),
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        ),
      ),
      GoRoute(
        path: '/word-list/:type',
        name: 'word-list',
        pageBuilder: (context, state) {
          final typeName = state.pathParameters['type']!;
          final type = WordListType.values.byName(typeName);
          return slideUpTransition(
            key: state.pageKey,
            child: WordListPage(type: type),
            duration: const Duration(milliseconds: 450),
          );
        },
      ),
    ],
  );
});

/// Helper class to make GoRouter refresh on auth/guest/settings state changes
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(this._ref) {
    _ref.listen(authStateProvider, (_, _) {
      notifyListeners();
    });
    _ref.listen(guestModeProvider, (_, _) {
      notifyListeners();
    });
    _ref.listen(settingsProvider, (_, _) {
      notifyListeners();
    });
  }

  final Ref _ref;
}

// Keep the old appRouter for backward compatibility during transition
// This will be removed after updating main.dart
final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      pageBuilder: (context, state) => fadeTransition(
        key: state.pageKey,
        child: const SplashPage(),
        duration: const Duration(milliseconds: 600),
      ),
    ),
    GoRoute(
      path: '/auth',
      name: 'auth',
      pageBuilder: (context, state) => fadeTransition(
        key: state.pageKey,
        child: const AuthPage(),
        duration: const Duration(milliseconds: 400),
      ),
    ),
    GoRoute(
      path: '/',
      name: 'home',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const HomePage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final curve = CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutQuad,
          );

          return AnimatedBuilder(
            animation: curve,
            builder: (context, child) {
              return ClipPath(
                clipper: CircularRevealClipper(fraction: curve.value),
                child: FadeTransition(
                  opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: const Interval(0.1, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: child,
                ),
              );
            },
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 900),
      ),
    ),
    GoRoute(
      path: '/decks',
      name: 'decks',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const DeckSelectionPage(),
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 450),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: false,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/swipe',
      name: 'swipe',
      pageBuilder: (context, state) {
        final deck = state.extra as WordDeck? ?? WordDeck.mixed;
        return CustomTransitionPage(
          key: state.pageKey,
          child: WordSwipePage(deck: deck),
          transitionDuration: const Duration(milliseconds: 450),
          reverseTransitionDuration: const Duration(milliseconds: 450),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return CupertinoPageTransition(
              primaryRouteAnimation: animation,
              secondaryRouteAnimation: secondaryAnimation,
              linearTransition: false,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: const SettingsPage(),
        transitionDuration: const Duration(milliseconds: 450),
        reverseTransitionDuration: const Duration(milliseconds: 450),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return CupertinoPageTransition(
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            linearTransition: false,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/word-list/:type',
      name: 'word-list',
      pageBuilder: (context, state) {
        final typeName = state.pathParameters['type']!;
        final type = WordListType.values.byName(typeName);
        return slideUpTransition(
          key: state.pageKey,
          child: WordListPage(type: type),
          duration: const Duration(milliseconds: 450),
        );
      },
    ),
  ],
);
