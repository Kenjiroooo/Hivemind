// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(communityRepository)
final communityRepositoryProvider = CommunityRepositoryProvider._();

final class CommunityRepositoryProvider
    extends
        $FunctionalProvider<
          CommunityRepository,
          CommunityRepository,
          CommunityRepository
        >
    with $Provider<CommunityRepository> {
  CommunityRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'communityRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$communityRepositoryHash();

  @$internal
  @override
  $ProviderElement<CommunityRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  CommunityRepository create(Ref ref) {
    return communityRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CommunityRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CommunityRepository>(value),
    );
  }
}

String _$communityRepositoryHash() =>
    r'ea25d031be736754e0c52fcc06192c9ca315311f';

@ProviderFor(myCommunities)
final myCommunitiesProvider = MyCommunitiesProvider._();

final class MyCommunitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Community>>,
          List<Community>,
          FutureOr<List<Community>>
        >
    with $FutureModifier<List<Community>>, $FutureProvider<List<Community>> {
  MyCommunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myCommunitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myCommunitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<Community>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Community>> create(Ref ref) {
    return myCommunities(ref);
  }
}

String _$myCommunitiesHash() => r'9e60124349aa164ef1282d097c13814598bd7848';
