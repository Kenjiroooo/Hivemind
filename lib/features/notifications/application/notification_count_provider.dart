import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/notification_repository.dart';

part 'notification_count_provider.g.dart';

@riverpod
int unreadNotificationCount(Ref ref) {
  final notificationsAsync = ref.watch(myNotificationsProvider);
  return notificationsAsync.maybeWhen(
    data: (list) => list.where((n) => !n.isRead).length,
    orElse: () => 0,
  );
}
