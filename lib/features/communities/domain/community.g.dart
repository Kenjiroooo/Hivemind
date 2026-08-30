// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Community _$CommunityFromJson(Map<String, dynamic> json) => _Community(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  bannerUrl: json['bannerUrl'] as String?,
  iconUrl: json['iconUrl'] as String?,
  memberCount: (json['memberCount'] as num?)?.toInt() ?? 0,
  isJoined: json['isJoined'] as bool? ?? false,
);

Map<String, dynamic> _$CommunityToJson(_Community instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'category': instance.category,
      'bannerUrl': instance.bannerUrl,
      'iconUrl': instance.iconUrl,
      'memberCount': instance.memberCount,
      'isJoined': instance.isJoined,
    };
