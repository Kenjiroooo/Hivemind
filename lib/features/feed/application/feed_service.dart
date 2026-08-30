import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/question.dart';
import '../data/feed_repository.dart';

part 'feed_service.g.dart';

@riverpod
class HomeFeed extends _$HomeFeed {
  @override
  FutureOr<List<Question>> build() async {
    return ref.watch(feedRepositoryProvider).getHomeFeed();
  }

  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() => ref.read(feedRepositoryProvider).getHomeFeed());
  }
}

@riverpod
class TrendingFeed extends _$TrendingFeed {
  @override
  FutureOr<List<Question>> build() async {
    return ref.watch(feedRepositoryProvider).getTrendingQuestions();
  }
}
