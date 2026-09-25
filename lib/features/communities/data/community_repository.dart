import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/community.dart';

part 'community_repository.g.dart';

abstract class CommunityRepository {
  Future<List<Community>> getMyCommunities();
  Future<List<Community>> getAllCommunities();
  Future<Community?> getCommunityDetails(String communityId);
  Future<void> toggleJoinCommunity(String communityId);
}

class MockCommunityRepository implements CommunityRepository {
  final List<Community> _mockCommunities = [
    const Community(
      id: 'c1',
      name: 'CPE3A Class Space',
      description: 'Official group for CPE3A Section 1. Study materials, problem sets, and announcements.',
      category: 'Class',
      memberCount: 45,
      isJoined: true,
    ),
    const Community(
      id: 'c2',
      name: 'Electronics Community',
      description: 'Discussions on microcontrollers, PCBs, and electronics projects.',
      category: 'Interest',
      memberCount: 230,
      isJoined: true,
    ),
    const Community(
      id: 'c3',
      name: 'Mathematics Club',
      description: 'For all math enthusiasts. Logic, calculus, and discrete mathematics.',
      category: 'Club',
      memberCount: 120,
      isJoined: false,
    ),
    const Community(
      id: 'c4',
      name: 'Computer Science Hub',
      description: 'Algorithms, data structures, competitive programming, and web dev.',
      category: 'Academic',
      memberCount: 340,
      isJoined: false,
    ),
  ];

  @override
  Future<List<Community>> getMyCommunities() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_mockCommunities.where((c) => c.isJoined).toList());
  }

  @override
  Future<List<Community>> getAllCommunities() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_mockCommunities);
  }

  @override
  Future<Community?> getCommunityDetails(String communityId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockCommunities.where((c) => c.id == communityId).firstOrNull;
  }

  @override
  Future<void> toggleJoinCommunity(String communityId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _mockCommunities.indexWhere((c) => c.id == communityId);
    if (index != -1) {
      final current = _mockCommunities[index];
      final newStatus = !current.isJoined;
      _mockCommunities[index] = current.copyWith(
        isJoined: newStatus,
        memberCount: current.memberCount + (newStatus ? 1 : -1),
      );
    }
  }
}

@Riverpod(keepAlive: true)
CommunityRepository communityRepository(Ref ref) {
  return MockCommunityRepository();
}

@riverpod
Future<List<Community>> myCommunities(Ref ref) {
  return ref.watch(communityRepositoryProvider).getMyCommunities();
}

@riverpod
Future<List<Community>> allCommunities(Ref ref) {
  return ref.watch(communityRepositoryProvider).getAllCommunities();
}

@riverpod
Future<Community?> communityDetail(Ref ref, String communityId) {
  return ref.watch(communityRepositoryProvider).getCommunityDetails(communityId);
}
