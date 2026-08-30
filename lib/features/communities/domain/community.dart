import 'package:freezed_annotation/freezed_annotation.dart';

part 'community.freezed.dart';
part 'community.g.dart';

@freezed
abstract class Community with _$Community {
  const factory Community({
    required String id,
    required String name,
    required String description,
    required String category, // e.g. Class, Subject, Interest
    String? bannerUrl,
    String? iconUrl,
    @Default(0) int memberCount,
    @Default(false) bool isJoined,
  }) = _Community;

  factory Community.fromJson(Map<String, dynamic> json) => _$CommunityFromJson(json);
}
