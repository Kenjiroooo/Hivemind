// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(HomeFeed)
final homeFeedProvider = HomeFeedProvider._();

final class HomeFeedProvider
    extends $AsyncNotifierProvider<HomeFeed, List<Question>> {
  HomeFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'homeFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$homeFeedHash();

  @$internal
  @override
  HomeFeed create() => HomeFeed();
}

String _$homeFeedHash() => r'2eaca238f640e3515ce61e1b7bf81d61625c7277';

abstract class _$HomeFeed extends $AsyncNotifier<List<Question>> {
  FutureOr<List<Question>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Question>>, List<Question>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Question>>, List<Question>>,
              AsyncValue<List<Question>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}

@ProviderFor(TrendingFeed)
final trendingFeedProvider = TrendingFeedProvider._();

final class TrendingFeedProvider
    extends $AsyncNotifierProvider<TrendingFeed, List<Question>> {
  TrendingFeedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trendingFeedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trendingFeedHash();

  @$internal
  @override
  TrendingFeed create() => TrendingFeed();
}

String _$trendingFeedHash() => r'2744b6153fb6ed489bb1fc08e92093a3fb81bf5c';

abstract class _$TrendingFeed extends $AsyncNotifier<List<Question>> {
  FutureOr<List<Question>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Question>>, List<Question>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Question>>, List<Question>>,
              AsyncValue<List<Question>>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
