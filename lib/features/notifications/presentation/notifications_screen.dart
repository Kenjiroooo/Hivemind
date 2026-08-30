import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:timeago/timeago.dart' as timeago;
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../data/notification_repository.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationsFuture = ref.watch(myNotificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        title: const Text('Notifications'),
      ),
      body: notificationsFuture.when(
        data: (notifications) {
          if (notifications.isEmpty) {
            return const Center(child: Text('No new notifications.'));
          }

          return ListView.builder(
            itemCount: notifications.length,
            itemBuilder: (context, index) {
              final notification = notifications[index];
              return ListTile(
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                tileColor: notification.isRead ? AppColors.surface : AppColors.primaryContainer.withValues(alpha: 0.2),
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
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
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
