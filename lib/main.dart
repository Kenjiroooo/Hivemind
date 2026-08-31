import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'routing/app_router.dart';
import 'core/theme/app_theme.dart';

void main() {
  runApp(
    // ProviderScope is required by Riverpod to store the state of providers.
    const ProviderScope(
      child: HivemindApp(),
    ),
  );
}

class HivemindApp extends ConsumerWidget {
  const HivemindApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the GoRouter configuration from our appRouter provider
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Hivemind',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: router,
    );
  }
}
