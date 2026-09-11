import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/premium_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../data/notification_repository.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsFuture = ref.watch(myNotificationsProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Notifications'),
      ),
      body: PremiumBackground(
        child: notificationsFuture.when(
          data: (notifications) {
            if (notifications.isEmpty) {
              return const Center(child: Text('No new notifications.'));
            }

            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: GlassCard(
                    padding: const EdgeInsets.all(0),
                    borderRadius: 16,
                    child: ListTile(
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      tileColor: notification.isRead ? Colors.transparent : AppColors.primary.withOpacity(0.05),
                      leading: _buildIcon(notification.type),
                      title: Text(
                        notification.title,
                        style: AppTypography.bodyLg.copyWith(
                          fontWeight: notification.isRead ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 4),
                          Text(
                            notification.message,
                            style: AppTypography.bodyMd,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            timeago.format(notification.createdAt),
                            style: AppTypography.labelMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                      onTap: () {
                        ref.read(notificationRepositoryProvider).markAsRead(notification.id);
                        if (notification.referenceId != null && notification.type == 'answer') {
                          context.push('/question/${notification.referenceId}');
                        }
                      },
                    ),
                  ).animate().fadeIn(delay: (50 * index).ms, duration: 400.ms).slideX(begin: 0.1, end: 0, duration: 400.ms, curve: Curves.easeOutCubic),
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error: $error')),
        ),
      ),
    );
  }

  Widget _buildIcon(String type) {
    IconData icon;
    Color color;

    switch (type) {
      case 'answer':
        icon = Icons.reply;
        color = Colors.blue;
        break;
      case 'upvote':
        icon = Icons.arrow_upward;
        color = Colors.green;
        break;
      case 'badge':
        icon = Icons.emoji_events;
        color = Colors.amber;
        break;
      default:
        icon = Icons.notifications;
        color = AppColors.primary;
    }

    return CircleAvatar(
      backgroundColor: color.withValues(alpha: 0.2),
      child: Icon(icon, color: color),
    );
  }
}
