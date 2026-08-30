import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/badge_icon.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/buttons.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../auth/application/auth_service.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: authState.when(
        data: (user) {
          if (user == null) {
            return const Center(child: Text('Not logged in.'));
          }

          final xpProgress = user.currentXp / user.nextLevelXp;

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Glossy Header
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                  decoration: BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    borderRadius: const BorderRadius.vertical(bottom: Radius.circular(40)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withValues(alpha: 0.2),
                        ),
                        child: UserAvatar(
                          imageUrl: user.photoUrl,
                          fallbackText: user.displayName,
                          size: 120,
                        ),
                      ).animate().scale(delay: 100.ms, duration: 400.ms, curve: Curves.easeOutBack),
                      const SizedBox(height: 16),
                      Text(
                        user.displayName,
                        style: AppTypography.headlineLg.copyWith(color: Colors.white),
                      ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.2, end: 0),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          '${user.major} • Year ${user.year}',
                          style: AppTypography.labelMd.copyWith(color: Colors.white),
                        ),
                      ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                    ],
                  ),
                ),
                
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 8),

                      // Gamification Stats
                      Container(
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.outlineVariant),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Level ${user.level}', style: AppTypography.headlineSm),
                                Text('${user.currentXp} / ${user.nextLevelXp} XP', style: AppTypography.bodyMd),
                              ],
                            ),
                            const SizedBox(height: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: LinearProgressIndicator(
                                value: xpProgress,
                                minHeight: 12,
                                backgroundColor: AppColors.surfaceVariant,
                                color: AppColors.primary,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildStatColumn('Reputation', user.reputation.toString()),
                                _buildStatColumn('Rank', '#${user.rank}'),
                                _buildStatColumn('Badges', user.badges.length.toString()),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),
                      
                      // Badges Section
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Badges',
                          style: AppTypography.headlineSm,
                        ),
                      ),
                      const SizedBox(height: 16),
                      if (user.badges.isEmpty)
                        const Center(child: Text('No badges earned yet.'))
                      else
                        Wrap(
                          spacing: 24,
                          runSpacing: 24,
                          alignment: WrapAlignment.start,
                          children: user.badges.map((b) => BadgeIcon(badgeName: b)).toList(),
                        ),
                      
                      const SizedBox(height: 32),
                      PrimaryButton(
                        onPressed: () {
                          context.push('/leaderboard');
                        },
                        icon: Icons.leaderboard,
                        label: 'View Leaderboard',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error loading profile: $error')),
      ),
    );
  }

  Widget _buildStatColumn(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: AppTypography.headlineMd.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: AppTypography.labelMd.copyWith(color: AppColors.onSurfaceVariant),
        ),
      ],
    );
  }
}
