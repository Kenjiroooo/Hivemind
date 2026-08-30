import 'package:freezed_annotation/freezed_annotation.dart';

part 'answer.freezed.dart';
part 'answer.g.dart';

@freezed
abstract class Answer with _$Answer {
  const factory Answer({
    required String id,
    required String questionId,
    required String content,
    required String authorId,
    required String authorName,
    String? authorPhotoUrl,
    required DateTime createdAt,
    @Default(0) int upvotes,
    @Default(false) bool isAccepted,
  }) = _Answer;

  factory Answer.fromJson(Map<String, dynamic> json) => _$AnswerFromJson(json);
}
