import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/premium_background.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/providers/token_provider.dart';
import '../../auth/application/auth_service.dart';
import 'package:flutter_animate/flutter_animate.dart';

class RewardItem {
  final String id;
  final String title;
  final String description;
  final int cost;
  final IconData icon;
  final bool isPhysical;

  const RewardItem({
    required this.id,
    required this.title,
    required this.description,
    required this.cost,
    required this.icon,
    this.isPhysical = false,
  });
}

const _digitalRewards = [
  RewardItem(
    id: 'd1',
    title: 'Hivemind Scholar Badge',
    description: 'A special badge on your profile showing your dedication.',
    cost: 300,
    icon: Icons.workspace_premium,
  ),
  RewardItem(
    id: 'd2',
    title: 'Gold Avatar Border',
    description: 'Stand out in the feed with a shiny gold border.',
    cost: 500,
    icon: Icons.account_circle,
  ),
];

const _physicalRewards = [
  RewardItem(
    id: 'p1',
    title: 'Hivemind Sticker Pack',
    description: 'Decorate your laptop with exclusive Hivemind stickers.',
    cost: 800,
    icon: Icons.sticky_note_2,
    isPhysical: true,
  ),
  RewardItem(
    id: 'p2',
    title: 'Premium Coffee Mug',
    description: 'Fuel your late-night coding sessions.',
    cost: 1500,
    icon: Icons.coffee,
    isPhysical: true,
  ),
  RewardItem(
    id: 'p3',
    title: 'Exclusive T-Shirt',
    description: 'High quality cotton tee with the Hivemind logo.',
    cost: 3000,
    icon: Icons.checkroom,
    isPhysical: true,
  ),
];

class RewardsScreen extends ConsumerWidget {
  const RewardsScreen({super.key});

  void _handleRedeem(BuildContext context, WidgetRef ref, RewardItem item, int currentBalance) {
    if (currentBalance < item.cost) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Not enough tokens! Keep answering questions to earn more.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('Redeem ${item.title}?'),
        content: Text(
          item.isPhysical 
            ? 'This will deduct ${item.cost} tokens. We will email you for shipping details.'
            : 'This will deduct ${item.cost} tokens and instantly apply to your profile.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            onPressed: () {
              Navigator.pop(ctx);
              ref.read(tokenControllerProvider.notifier).deductTokens(item.cost, reason: 'Redeemed ${item.title}');
              
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('🎉 Successfully redeemed ${item.title}!'),
                  backgroundColor: AppColors.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: const Text('Redeem', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).valueOrNull;
    final tokenBalance = user?.tokenBalance ?? 0;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Rewards Store'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.tertiaryContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.stars, color: AppColors.tertiary, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      '$tokenBalance',
                      style: AppTypography.labelLg.copyWith(
                        color: AppColors.onTertiaryContainer,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ).animate().shimmer(duration: 2000.ms),
            ),
          ),
        ],
      ),
      body: PremiumBackground(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Hero section
              GlassCard(
                padding: const EdgeInsets.all(24),
                borderRadius: 24,
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Exchange your Tokens!', style: AppTypography.headlineSm),
                          const SizedBox(height: 8),
                          Text(
                            'Earn more tokens by providing helpful answers that get upvoted or marked as the Best Answer.',
                            style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),
                    Icon(Icons.storefront, size: 64, color: AppColors.primary.withValues(alpha: 0.8)),
                  ],
                ),
              ).animate().fadeIn().slideY(begin: 0.2),

              const SizedBox(height: 32),
              
              // Digital Perks
              Text('Digital Perks', style: AppTypography.headlineSm),
              const SizedBox(height: 16),
              ..._digitalRewards.map((item) => _buildRewardCard(context, ref, item, tokenBalance)).toList(),

              const SizedBox(height: 32),

              // Physical Merchandise
              Row(
                children: [
                  Text('Physical Merchandise', style: AppTypography.headlineSm),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryContainer,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text('IRL', style: AppTypography.labelSm.copyWith(color: AppColors.onSecondaryContainer)),
                  )
                ],
              ),
              const SizedBox(height: 16),
              ..._physicalRewards.map((item) => _buildRewardCard(context, ref, item, tokenBalance)).toList(),
              const SizedBox(height: 64),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRewardCard(BuildContext context, WidgetRef ref, RewardItem item, int balance) {
    final canAfford = balance >= item.cost;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.primaryContainer.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(item.icon, size: 32, color: AppColors.primary),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppTypography.titleMd),
                  const SizedBox(height: 4),
                  Text(
                    item.description,
                    style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              children: [
                Row(
                  children: [
                    const Icon(Icons.stars, color: AppColors.tertiary, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${item.cost}',
                      style: AppTypography.titleMd.copyWith(
                        color: canAfford ? AppColors.onSurface : AppColors.error,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => _handleRedeem(context, ref, item, balance),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: canAfford ? AppColors.primary : AppColors.surfaceVariant,
                    foregroundColor: canAfford ? Colors.white : AppColors.onSurfaceVariant,
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    minimumSize: const Size(80, 36),
                  ),
                  child: const Text('Redeem'),
                ),
              ],
            ),
          ],
        ),
      ).animate().fadeIn(duration: 400.ms).slideX(begin: 0.1),
    );
  }
}
