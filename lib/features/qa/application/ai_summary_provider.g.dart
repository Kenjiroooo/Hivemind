// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_summary_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Returns a contextual AI summary for a question based on its ID and tags.
/// For MVP, this returns pre-written summaries mapped to question IDs.
/// The architecture is designed so the body of this provider can be
/// swapped with a real LLM API call (Gemini, OpenAI, etc.) in the future.

@ProviderFor(aiSummary)
final aiSummaryProvider = AiSummaryFamily._();

/// Returns a contextual AI summary for a question based on its ID and tags.
/// For MVP, this returns pre-written summaries mapped to question IDs.
/// The architecture is designed so the body of this provider can be
/// swapped with a real LLM API call (Gemini, OpenAI, etc.) in the future.

final class AiSummaryProvider
    extends $FunctionalProvider<AsyncValue<String?>, String?, FutureOr<String?>>
    with $FutureModifier<String?>, $FutureProvider<String?> {
  /// Returns a contextual AI summary for a question based on its ID and tags.
  /// For MVP, this returns pre-written summaries mapped to question IDs.
  /// The architecture is designed so the body of this provider can be
  /// swapped with a real LLM API call (Gemini, OpenAI, etc.) in the future.
  AiSummaryProvider._({
    required AiSummaryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'aiSummaryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$aiSummaryHash();

  @override
  String toString() {
    return r'aiSummaryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String?> create(Ref ref) {
    final argument = this.argument as String;
    return aiSummary(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AiSummaryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$aiSummaryHash() => r'4af88c3bcb7cebcdd683a20f267c2a15739c7490';

/// Returns a contextual AI summary for a question based on its ID and tags.
/// For MVP, this returns pre-written summaries mapped to question IDs.
/// The architecture is designed so the body of this provider can be
/// swapped with a real LLM API call (Gemini, OpenAI, etc.) in the future.

final class AiSummaryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String?>, String> {
  AiSummaryFamily._()
    : super(
        retry: null,
        name: r'aiSummaryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Returns a contextual AI summary for a question based on its ID and tags.
  /// For MVP, this returns pre-written summaries mapped to question IDs.
  /// The architecture is designed so the body of this provider can be
  /// swapped with a real LLM API call (Gemini, OpenAI, etc.) in the future.

  AiSummaryProvider call(String questionId) =>
      AiSummaryProvider._(argument: questionId, from: this);

  @override
  String toString() => r'aiSummaryProvider';
}
