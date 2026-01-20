import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import '../../domain/models/word_deck.dart';
import '../../presentation/pages/home_page.dart';
import '../../presentation/pages/word_swipe_page.dart';
import '../../presentation/pages/settings_page.dart';
import '../../presentation/pages/splash_page.dart';
import '../../presentation/pages/word_list_page.dart';
import '../../presentation/pages/deck_selection_page.dart';
import '../../presentation/pages/custom_deck_page.dart';
import 'page_transitions.dart';

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
                clipper: CircularRevealClipper(
                  fraction: curve.value,
                ),
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
    GoRoute(
      path: '/custom-deck',
      name: 'custom-deck',
      pageBuilder: (context, state) {
        final deckName = state.extra as String;
        return CustomTransitionPage(
          key: state.pageKey,
          child: CustomDeckPage(deckName: deckName),
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
  ],
);
