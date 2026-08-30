import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String displayName,
    String? photoUrl,
    @Default(0) int reputation,
    @Default(1) int level,
    @Default(0) int currentXp,
    @Default(100) int nextLevelXp,
    @Default(0) int rank,
    @Default([]) List<String> badges,
    @Default('student') String role,
    @Default('Undeclared') String major,
    @Default(1) int year,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
