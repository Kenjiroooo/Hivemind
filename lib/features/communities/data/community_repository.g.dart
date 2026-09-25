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
        isAutoDispose: false,
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
    r'67fb5dc33e1ab519cd3c8894c36a6ce0143715f5';

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

@ProviderFor(allCommunities)
final allCommunitiesProvider = AllCommunitiesProvider._();

final class AllCommunitiesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Community>>,
          List<Community>,
          FutureOr<List<Community>>
        >
    with $FutureModifier<List<Community>>, $FutureProvider<List<Community>> {
  AllCommunitiesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allCommunitiesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allCommunitiesHash();

  @$internal
  @override
  $FutureProviderElement<List<Community>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Community>> create(Ref ref) {
    return allCommunities(ref);
  }
}

String _$allCommunitiesHash() => r'ca2d85ab6282a3150bb524cd9a4b39012245dfa2';

@ProviderFor(communityDetail)
final communityDetailProvider = CommunityDetailFamily._();

final class CommunityDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Community?>,
          Community?,
          FutureOr<Community?>
        >
    with $FutureModifier<Community?>, $FutureProvider<Community?> {
  CommunityDetailProvider._({
    required CommunityDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'communityDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$communityDetailHash();

  @override
  String toString() {
    return r'communityDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Community?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Community?> create(Ref ref) {
    final argument = this.argument as String;
    return communityDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CommunityDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$communityDetailHash() => r'6788ea3175cddfefd57ba0a819349297cff24d5a';

final class CommunityDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Community?>, String> {
  CommunityDetailFamily._()
    : super(
        retry: null,
        name: r'communityDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CommunityDetailProvider call(String communityId) =>
      CommunityDetailProvider._(argument: communityId, from: this);

  @override
  String toString() => r'communityDetailProvider';
}
