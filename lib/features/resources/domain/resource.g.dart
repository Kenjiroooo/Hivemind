// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'resource.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Resource _$ResourceFromJson(Map<String, dynamic> json) => _Resource(
  id: json['id'] as String,
  title: json['title'] as String,
  type: json['type'] as String,
  uploaderId: json['uploaderId'] as String,
  uploaderName: json['uploaderName'] as String,
  communityId: json['communityId'] as String,
  communityName: json['communityName'] as String,
  uploadedAt: DateTime.parse(json['uploadedAt'] as String),
  url: json['url'] as String,
  sizeBytes: (json['sizeBytes'] as num?)?.toInt() ?? 0,
  downloads: (json['downloads'] as num?)?.toInt() ?? 0,
  upvotes: (json['upvotes'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$ResourceToJson(_Resource instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'type': instance.type,
  'uploaderId': instance.uploaderId,
  'uploaderName': instance.uploaderName,
  'communityId': instance.communityId,
  'communityName': instance.communityName,
  'uploadedAt': instance.uploadedAt.toIso8601String(),
  'url': instance.url,
  'sizeBytes': instance.sizeBytes,
  'downloads': instance.downloads,
  'upvotes': instance.upvotes,
};
