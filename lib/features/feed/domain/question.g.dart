// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Question _$QuestionFromJson(Map<String, dynamic> json) => _Question(
  id: json['id'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  authorId: json['authorId'] as String,
  authorName: json['authorName'] as String,
  authorPhotoUrl: json['authorPhotoUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  upvotes: (json['upvotes'] as num?)?.toInt() ?? 0,
  answerCount: (json['answerCount'] as num?)?.toInt() ?? 0,
  isResolved: json['isResolved'] as bool? ?? false,
);

Map<String, dynamic> _$QuestionToJson(_Question instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'content': instance.content,
  'authorId': instance.authorId,
  'authorName': instance.authorName,
  'authorPhotoUrl': instance.authorPhotoUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'tags': instance.tags,
  'upvotes': instance.upvotes,
  'answerCount': instance.answerCount,
  'isResolved': instance.isResolved,
};
