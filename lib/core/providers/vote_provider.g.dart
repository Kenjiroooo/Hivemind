// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vote_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(VoteNotifier)
final voteProvider = VoteNotifierProvider._();

final class VoteNotifierProvider
    extends $NotifierProvider<VoteNotifier, VoteState> {
  VoteNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'voteProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$voteNotifierHash();

  @$internal
  @override
  VoteNotifier create() => VoteNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VoteState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VoteState>(value),
    );
  }
}

String _$voteNotifierHash() => r'dd9e9e962f4afcd4b47218481ce312f355ea864b';

abstract class _$VoteNotifier extends $Notifier<VoteState> {
  VoteState build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<VoteState, VoteState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<VoteState, VoteState>,
              VoteState,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
