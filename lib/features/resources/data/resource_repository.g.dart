// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(resourceRepository)
final resourceRepositoryProvider = ResourceRepositoryProvider._();

final class ResourceRepositoryProvider
    extends
        $FunctionalProvider<
          ResourceRepository,
          ResourceRepository,
          ResourceRepository
        >
    with $Provider<ResourceRepository> {
  ResourceRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'resourceRepositoryProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$resourceRepositoryHash();

  @$internal
  @override
  $ProviderElement<ResourceRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  ResourceRepository create(Ref ref) {
    return resourceRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(ResourceRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<ResourceRepository>(value),
    );
  }
}

String _$resourceRepositoryHash() =>
    r'c01eb92a361388fa896b64b097fda314c476f8ae';

@ProviderFor(recentResources)
final recentResourcesProvider = RecentResourcesProvider._();

final class RecentResourcesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Resource>>,
          List<Resource>,
          FutureOr<List<Resource>>
        >
    with $FutureModifier<List<Resource>>, $FutureProvider<List<Resource>> {
  RecentResourcesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'recentResourcesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$recentResourcesHash();

  @$internal
  @override
  $FutureProviderElement<List<Resource>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Resource>> create(Ref ref) {
    return recentResources(ref);
  }
}

String _$recentResourcesHash() => r'fd3a68d0a2262bc529dd2722bd31bc87e1599c85';

@ProviderFor(resourceDetail)
final resourceDetailProvider = ResourceDetailFamily._();

final class ResourceDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Resource?>,
          Resource?,
          FutureOr<Resource?>
        >
    with $FutureModifier<Resource?>, $FutureProvider<Resource?> {
  ResourceDetailProvider._({
    required ResourceDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'resourceDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resourceDetailHash();

  @override
  String toString() {
    return r'resourceDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Resource?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Resource?> create(Ref ref) {
    final argument = this.argument as String;
    return resourceDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ResourceDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resourceDetailHash() => r'a12e95136d0ca6d6f6920e494896f3ecfe5b550f';

final class ResourceDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Resource?>, String> {
  ResourceDetailFamily._()
    : super(
        retry: null,
        name: r'resourceDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResourceDetailProvider call(String resourceId) =>
      ResourceDetailProvider._(argument: resourceId, from: this);

  @override
  String toString() => r'resourceDetailProvider';
}

@ProviderFor(resourcesByCommunity)
final resourcesByCommunityProvider = ResourcesByCommunityFamily._();

final class ResourcesByCommunityProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Resource>>,
          List<Resource>,
          FutureOr<List<Resource>>
        >
    with $FutureModifier<List<Resource>>, $FutureProvider<List<Resource>> {
  ResourcesByCommunityProvider._({
    required ResourcesByCommunityFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'resourcesByCommunityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$resourcesByCommunityHash();

  @override
  String toString() {
    return r'resourcesByCommunityProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Resource>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Resource>> create(Ref ref) {
    final argument = this.argument as String;
    return resourcesByCommunity(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ResourcesByCommunityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$resourcesByCommunityHash() =>
    r'a5518c1f0e1df23ac01d2cc406bb6f2ac7c4c998';

final class ResourcesByCommunityFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Resource>>, String> {
  ResourcesByCommunityFamily._()
    : super(
        retry: null,
        name: r'resourcesByCommunityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  ResourcesByCommunityProvider call(String communityId) =>
      ResourcesByCommunityProvider._(argument: communityId, from: this);

  @override
  String toString() => r'resourcesByCommunityProvider';
}
