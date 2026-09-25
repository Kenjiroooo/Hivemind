import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../feed/application/feed_service.dart';
import '../../feed/domain/question.dart';
import '../../auth/application/auth_service.dart';

part 'profile_activity_provider.g.dart';

@riverpod
Future<List<Question>> userQuestions(Ref ref) async {
  final user = ref.watch(authControllerProvider).value;
  if (user == null) return [];
  final feed = await ref.watch(homeFeedProvider.future);
  return feed.where((q) => q.authorId == user.id || q.authorName == user.displayName || q.authorName == 'You').toList();
}
