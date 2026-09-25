import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/user_avatar.dart';
import '../../../core/widgets/premium_background.dart';
import '../../../core/widgets/question_card.dart';
import '../../auth/application/auth_service.dart';
import '../application/profile_activity_provider.dart';
import '../../../core/widgets/badge_icon.dart';
import 'package:flutter_animate/flutter_animate.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  int _selectedActivityTab = 0; // 0 = My Questions, 1 = Activity Info

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Sign Out'),
                  content: const Text(
                    'Are you sure you want to sign out of Hivemind?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text(
                        'Sign Out',
                        style: TextStyle(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
              );
              if (confirmed == true) {
                await ref.read(authControllerProvider.notifier).signOut();
              }
            },
          ),
        ],
      ),
      body: PremiumBackground(
        child: authState.when(
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
                        GlassCard(
                          padding: const EdgeInsets.all(24),
                          borderRadius: 24,
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
                                  backgroundColor: AppColors.surfaceVariant.withValues(alpha: 0.5),
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
                        ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0, curve: Curves.easeOutCubic),

                        const SizedBox(height: 32),

                        // Badges Section
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Badges', style: AppTypography.headlineSm),
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
                          onPressed: () => context.push('/leaderboard'),
                          icon: Icons.leaderboard,
                          label: 'View Campus Leaderboard',
                        ),

                        const SizedBox(height: 32),

                        // Activity Tabs (Tasks 5.3)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text('My Activity', style: AppTypography.headlineSm),
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            _buildActivityTab(0, 'My Questions'),
                            const SizedBox(width: 12),
                            _buildActivityTab(1, 'Stats Summary'),
                          ],
                        ),
                        const SizedBox(height: 16),

                        if (_selectedActivityTab == 0) _buildMyQuestionsSection() else _buildStatsSummarySection(user),
                        const SizedBox(height: 32),
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
      ),
    );
  }

  Widget _buildActivityTab(int index, String label) {
    final isSelected = _selectedActivityTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedActivityTab = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: AppColors.outlineVariant),
        ),
        child: Text(
          label,
          style: AppTypography.labelMd.copyWith(
            color: isSelected ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildMyQuestionsSection() {
    final questionsAsync = ref.watch(userQuestionsProvider);

    return questionsAsync.when(
      data: (questions) {
        if (questions.isEmpty) {
          return GlassCard(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                Icon(Icons.forum_outlined, size: 48, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                const SizedBox(height: 12),
                Text('No questions asked yet', style: AppTypography.headlineSm.copyWith(fontSize: 18)),
                const SizedBox(height: 6),
                Text(
                  'Post your first question to get answers and earn reputation.',
                  style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton.icon(
                  onPressed: () => context.push('/ask'),
                  icon: const Icon(Icons.add),
                  label: const Text('Ask a Question'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: questions
              .map((q) => QuestionCard(
                    question: q,
                    onTap: () => context.push('/question/${q.id}'),
                  ))
              .toList(),
        );
      },
      loading: () => const Center(child: Padding(padding: EdgeInsets.all(24), child: CircularProgressIndicator())),
      error: (e, st) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildStatsSummarySection(dynamic user) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.auto_awesome, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('Contribution Summary', style: AppTypography.headlineSm.copyWith(fontSize: 18)),
            ],
          ),
          const SizedBox(height: 16),
          _buildSummaryRow(Icons.help_outline, 'Questions Asked', 'Active in community'),
          const Divider(height: 20),
          _buildSummaryRow(Icons.check_circle_outline, 'Solutions Provided', 'Verified peer responses'),
          const Divider(height: 20),
          _buildSummaryRow(Icons.thumb_up_alt_outlined, 'Helpful Votes', '${user.reputation} points earned'),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(IconData icon, String title, String desc) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.onSurfaceVariant),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTypography.bodyMd.copyWith(fontWeight: FontWeight.bold)),
            Text(desc, style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),
      ],
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
