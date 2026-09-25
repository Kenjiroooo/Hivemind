// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_activity_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(userQuestions)
final userQuestionsProvider = UserQuestionsProvider._();

final class UserQuestionsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Question>>,
          List<Question>,
          FutureOr<List<Question>>
        >
    with $FutureModifier<List<Question>>, $FutureProvider<List<Question>> {
  UserQuestionsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userQuestionsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userQuestionsHash();

  @$internal
  @override
  $FutureProviderElement<List<Question>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Question>> create(Ref ref) {
    return userQuestions(ref);
  }
}

String _$userQuestionsHash() => r'cc7dc6360a8e933db232eb1b9795742476dff841';
