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
        isAutoDispose: true,
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
    r'20fcd9ec761970b6d1ef2870ca64fbb40f49477e';

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
