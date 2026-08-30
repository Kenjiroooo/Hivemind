import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/notification_model.dart';

part 'notification_repository.g.dart';

abstract class NotificationRepository {
  Future<List<AppNotification>> getNotifications();
  Future<void> markAsRead(String id);
}

class MockNotificationRepository implements NotificationRepository {
  final _mockNotifications = [
    AppNotification(
      id: 'n1',
      title: 'New Answer',
      message: 'Dr. Emily Chen answered your question about "Digital Logic Gates".',
      createdAt: DateTime.now().subtract(const Duration(minutes: 5)),
      type: 'answer',
      isRead: false,
      referenceId: 'q1',
    ),
    AppNotification(
      id: 'n2',
      title: 'Upvote Milestone',
      message: 'Your answer on "Arduino Setup" reached 10 upvotes!',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      type: 'upvote',
      isRead: true,
      referenceId: 'q2',
    ),
    AppNotification(
      id: 'n3',
      title: 'Badge Earned',
      message: 'You earned the "Helpful" badge!',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      type: 'badge',
      isRead: true,
    ),
  ];

  @override
  Future<List<AppNotification>> getNotifications() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockNotifications;
  }

  @override
  Future<void> markAsRead(String id) async {
    // Mock update
    final index = _mockNotifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _mockNotifications[index] = _mockNotifications[index].copyWith(isRead: true);
    }
  }
}

@riverpod
NotificationRepository notificationRepository(Ref ref) {
  return MockNotificationRepository();
}

@riverpod
Future<List<AppNotification>> myNotifications(Ref ref) {
  return ref.watch(notificationRepositoryProvider).getNotifications();
}
