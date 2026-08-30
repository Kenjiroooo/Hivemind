import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'top_app_bar.dart';
import 'bottom_nav_bar.dart';
import 'desktop_sidebar.dart';
import '../theme/app_colors.dart';
import '../../features/auth/application/auth_service.dart';

class MainShell extends ConsumerWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _calculateBottomNavIndex(String location) {
    if (location.startsWith('/explore')) return 1;
    if (location.startsWith('/resources')) return 2;
    if (location.startsWith('/profile')) return 3;
    return 0; // Default to Home
  }

  int _calculateSidebarIndex(String location) {
    if (location.contains('category=CPE')) return 1;
    if (location.contains('category=Programming')) return 2;
    if (location.contains('category=Electronics')) return 3;
    if (location.contains('category=Mathematics')) return 4;
    return 0; // Default to For You
  }

  void _onBottomNavSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/explore');
        break;
      case 2:
        context.go('/resources');
        break;
      case 3:
        context.go('/profile');
        break;
    }
  }

  void _onSidebarSelected(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/explore?category=CPE');
        break;
      case 2:
        context.go('/explore?category=Programming');
        break;
      case 3:
        context.go('/explore?category=Electronics');
        break;
      case 4:
        context.go('/explore?category=Mathematics');
        break;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isDesktop = MediaQuery.of(context).size.width >= 768; // md breakpoint
    final location = GoRouterState.of(context).uri.toString();
    final authState = ref.watch(authControllerProvider);
    final user = authState.value;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: TopAppBar(
        isMobile: !isDesktop,
        userName: user?.displayName ?? 'Guest',
        userPhotoUrl: user?.photoUrl,
        onSearchPressed: () {},
        onNotificationsPressed: () {
          context.push('/notifications');
        },
        onProfilePressed: () {
          context.go('/profile');
        },
      ),
      body: isDesktop ? _buildDesktopLayout(context, location, user?.displayName) : _buildMobileLayout(),
      bottomNavigationBar: isDesktop 
          ? null 
          : BottomNavBar(
              currentIndex: _calculateBottomNavIndex(location),
              onTabSelected: (index) => _onBottomNavSelected(context, index),
              onFabPressed: () {
                context.push('/ask');
              },
            ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, String location, String? userName) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DesktopSidebar(
                currentIndex: _calculateSidebarIndex(location),
                onTabSelected: (index) => _onSidebarSelected(context, index),
                userName: userName ?? 'Guest',
              ),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMobileLayout() {
    return child;
  }
}
