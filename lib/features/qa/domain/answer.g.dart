// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Answer _$AnswerFromJson(Map<String, dynamic> json) => _Answer(
  id: json['id'] as String,
  questionId: json['questionId'] as String,
  content: json['content'] as String,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  authorPhotoUrl: json['authorPhotoUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  upvotes: (json['upvotes'] as num?)?.toInt() ?? 0,
  isAccepted: json['isAccepted'] as bool? ?? false,
);

Map<String, dynamic> _$AnswerToJson(_Answer instance) => <String, dynamic>{
  'id': instance.id,
  'questionId': instance.questionId,
  'content': instance.content,
  'authorId': instance.authorId,
  'authorName': instance.authorName,
  'authorPhotoUrl': instance.authorPhotoUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'upvotes': instance.upvotes,
  'isAccepted': instance.isAccepted,
};
