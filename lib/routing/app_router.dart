import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../core/widgets/main_shell.dart';
import '../features/auth/application/auth_service.dart';
import '../features/auth/presentation/login_screen.dart';
import '../features/auth/presentation/register_screen.dart';
import '../features/feed/presentation/home_screen.dart';
import '../features/feed/presentation/explore_screen.dart';
import '../features/qa/presentation/question_detail_screen.dart';
import '../features/qa/presentation/ask_question_screen.dart';
import '../features/resources/presentation/resources_screen.dart';
import '../features/resources/presentation/resource_detail_screen.dart';
import '../features/communities/presentation/community_screen.dart';
import '../features/profile/presentation/profile_screen.dart';
import '../features/profile/presentation/leaderboard_screen.dart';
import '../features/notifications/presentation/notifications_screen.dart';

import 'package:flutter/material.dart';

part 'app_router.g.dart';

// Custom Fade Transition
CustomTransitionPage<void> _fadeTransition(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

// Custom Slide Transition
CustomTransitionPage<void> _slideTransition(BuildContext context, GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOut;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(position: animation.drive(tween), child: child);
    },
  );
}

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authControllerProvider);

  return GoRouter(
    initialLocation: '/',
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isLoading = authState.isLoading;
      if (isLoading) return null;

      final isAuth = authState.value != null;
      final isLoggingIn = state.uri.path == '/login' || state.uri.path == '/register';

      if (!isAuth && !isLoggingIn) return '/login';
      if (isAuth && isLoggingIn) return '/';
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder: (context, state) => _fadeTransition(context, state, const HomeScreen()),
          ),
          GoRoute(
            path: '/explore',
            pageBuilder: (context, state) {
              final category = state.uri.queryParameters['category'];
              return _fadeTransition(context, state, ExploreScreen(category: category));
            },
          ),
          GoRoute(
            path: '/resources',
            pageBuilder: (context, state) => _fadeTransition(context, state, const ResourcesScreen()),
          ),
          GoRoute(
            path: '/notifications',
            pageBuilder: (context, state) => _fadeTransition(context, state, const NotificationsScreen()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => _fadeTransition(context, state, const ProfileScreen()),
          ),
        ],
      ),
      GoRoute(
        path: '/question/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _slideTransition(context, state, QuestionDetailScreen(questionId: id));
        },
      ),
      GoRoute(
        path: '/ask',
        pageBuilder: (context, state) => _slideTransition(context, state, const AskQuestionScreen()),
      ),
      GoRoute(
        path: '/resource/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _slideTransition(context, state, ResourceDetailScreen(resourceId: id));
        },
      ),
      GoRoute(
        path: '/community/:id',
        pageBuilder: (context, state) {
          final id = state.pathParameters['id']!;
          return _slideTransition(context, state, CommunityScreen(communityId: id));
        },
      ),
      GoRoute(
        path: '/leaderboard',
        pageBuilder: (context, state) => _slideTransition(context, state, const LeaderboardScreen()),
      ),
    ],
  );
}
