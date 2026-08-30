import 'package:freezed_annotation/freezed_annotation.dart';

part 'resource.freezed.dart';
part 'resource.g.dart';

@freezed
abstract class Resource with _$Resource {
  const factory Resource({
    required String id,
    required String title,
    required String type, // PDF, Link, Note, Video
    required String uploaderId,
    required String uploaderName,
    required String communityId,
    required String communityName,
    required DateTime uploadedAt,
    required String url,
    @Default(0) int sizeBytes,
    @Default(0) int downloads,
    @Default(0) int upvotes,
  }) = _Resource;

  factory Resource.fromJson(Map<String, dynamic> json) => _$ResourceFromJson(json);
}
