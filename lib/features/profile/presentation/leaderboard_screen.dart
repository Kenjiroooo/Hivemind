import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/premium_background.dart';
import '../../../core/widgets/glass_card.dart';

class LeaderboardScreen extends ConsumerWidget {
  const LeaderboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Mocking leaderboard data for MVP
    final topUsers = [
      {'name': 'Kenji', 'xp': 2450, 'level': 5, 'rank': 1, 'badges': 4},
      {'name': 'Dr. Emily Chen', 'xp': 2100, 'level': 5, 'rank': 2, 'badges': 6},
      {'name': 'Sam Rodgers', 'xp': 1800, 'level': 4, 'rank': 3, 'badges': 2},
      {'name': 'Alex Kim', 'xp': 1500, 'level': 3, 'rank': 4, 'badges': 1},
      {'name': 'Prof. Davis', 'xp': 1200, 'level': 3, 'rank': 5, 'badges': 5},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('University Leaderboard'),
      ),
      body: PremiumBackground(
        child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Icon(Icons.emoji_events, size: 64, color: Colors.amber),
                  const SizedBox(height: 16),
                  Text(
                    'Top Contributors',
                    style: AppTypography.headlineLg,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'The most helpful students and faculty in the hive.',
                    style: AppTypography.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final user = topUsers[index];
                  final isTopThree = index < 3;
                  
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GlassCard(
                      padding: const EdgeInsets.all(0),
                      borderRadius: 16,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: index == 0 ? Colors.amber 
                                 : (index == 1 ? Colors.grey.shade400 
                                 : (index == 2 ? Colors.brown.shade300 
                                 : Colors.transparent)),
                            width: isTopThree ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(16),
                          color: isTopThree ? AppColors.surfaceContainerHigh.withOpacity(0.5) : Colors.transparent,
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '#${user['rank']}',
                                style: AppTypography.headlineSm.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isTopThree ? AppColors.primary : AppColors.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(width: 16),
                              UserAvatar(
                                imageUrl: null,
                                fallbackText: user['name'] as String,
                                size: 48,
                              ),
                            ],
                          ),
                          title: Text(
                            user['name'] as String,
                            style: AppTypography.bodyLg.copyWith(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text('Level ${user['level']} • ${user['badges']} Badges'),
                          trailing: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${user['xp']}',
                                style: AppTypography.headlineSm.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
                              ),
                              Text('XP', style: AppTypography.labelMd),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: (50 * index).ms, duration: 400.ms).slideY(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOutCubic);
                },
                childCount: topUsers.length,
              ),
            ),
          ),
        ],
      ),
    ),
  );
  }
}
