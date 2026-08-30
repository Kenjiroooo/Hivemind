// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AppUser _$AppUserFromJson(Map<String, dynamic> json) => _AppUser(
  id: json['id'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  photoUrl: json['photoUrl'] as String?,
  reputation: (json['reputation'] as num?)?.toInt() ?? 0,
  level: (json['level'] as num?)?.toInt() ?? 1,
  currentXp: (json['currentXp'] as num?)?.toInt() ?? 0,
  nextLevelXp: (json['nextLevelXp'] as num?)?.toInt() ?? 100,
  rank: (json['rank'] as num?)?.toInt() ?? 0,
  badges:
      (json['badges'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  role: json['role'] as String? ?? 'student',
  major: json['major'] as String? ?? 'Undeclared',
  year: (json['year'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$AppUserToJson(_AppUser instance) => <String, dynamic>{
  'id': instance.id,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'reputation': instance.reputation,
  'level': instance.level,
  'currentXp': instance.currentXp,
  'nextLevelXp': instance.nextLevelXp,
  'rank': instance.rank,
  'badges': instance.badges,
  'role': instance.role,
  'major': instance.major,
  'year': instance.year,
};
