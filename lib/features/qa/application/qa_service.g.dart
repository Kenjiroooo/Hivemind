// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qa_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(questionDetail)
final questionDetailProvider = QuestionDetailFamily._();

final class QuestionDetailProvider
    extends
        $FunctionalProvider<
          AsyncValue<Question?>,
          Question?,
          FutureOr<Question?>
        >
    with $FutureModifier<Question?>, $FutureProvider<Question?> {
  QuestionDetailProvider._({
    required QuestionDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'questionDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$questionDetailHash();

  @override
  String toString() {
    return r'questionDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Question?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Question?> create(Ref ref) {
    final argument = this.argument as String;
    return questionDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$questionDetailHash() => r'9efafefd20a9b1c0ba25c94934d18a7de7bbff22';

final class QuestionDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Question?>, String> {
  QuestionDetailFamily._()
    : super(
        retry: null,
        name: r'questionDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuestionDetailProvider call(String questionId) =>
      QuestionDetailProvider._(argument: questionId, from: this);

  @override
  String toString() => r'questionDetailProvider';
}

@ProviderFor(questionAnswers)
final questionAnswersProvider = QuestionAnswersFamily._();

final class QuestionAnswersProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Answer>>,
          List<Answer>,
          FutureOr<List<Answer>>
        >
    with $FutureModifier<List<Answer>>, $FutureProvider<List<Answer>> {
  QuestionAnswersProvider._({
    required QuestionAnswersFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'questionAnswersProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$questionAnswersHash();

  @override
  String toString() {
    return r'questionAnswersProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Answer>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Answer>> create(Ref ref) {
    final argument = this.argument as String;
    return questionAnswers(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is QuestionAnswersProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$questionAnswersHash() => r'07e493608a1669d9d4d31c0722c522540741c184';

final class QuestionAnswersFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Answer>>, String> {
  QuestionAnswersFamily._()
    : super(
        retry: null,
        name: r'questionAnswersProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  QuestionAnswersProvider call(String questionId) =>
      QuestionAnswersProvider._(argument: questionId, from: this);

  @override
  String toString() => r'questionAnswersProvider';
}
