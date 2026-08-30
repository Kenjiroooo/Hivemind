import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/community.dart';

part 'community_repository.g.dart';

abstract class CommunityRepository {
  Future<List<Community>> getMyCommunities();
  Future<List<Community>> getAllCommunities();
  Future<Community?> getCommunityDetails(String communityId);
}

class MockCommunityRepository implements CommunityRepository {
  @override
  Future<List<Community>> getMyCommunities() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockCommunities.where((c) => c.isJoined).toList();
  }

  @override
  Future<List<Community>> getAllCommunities() async {
    await Future.delayed(const Duration(milliseconds: 800));
    return _mockCommunities;
  }

  @override
  Future<Community?> getCommunityDetails(String communityId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockCommunities.where((c) => c.id == communityId).firstOrNull;
  }

  final _mockCommunities = const [
    Community(
      id: 'c1',
      name: 'CPE3A Class Space',
      description: 'Official group for CPE3A Section 1.',
      category: 'Class',
      memberCount: 45,
      isJoined: true,
    ),
    Community(
      id: 'c2',
      name: 'Electronics Community',
      description: 'Discussions on microcontrollers, PCBs, and electronics projects.',
      category: 'Interest',
      memberCount: 230,
      isJoined: true,
    ),
    Community(
      id: 'c3',
      name: 'Mathematics Club',
      description: 'For all math enthusiasts.',
      category: 'Club',
      memberCount: 120,
      isJoined: false,
    ),
  ];
}

@riverpod
CommunityRepository communityRepository(Ref ref) {
  return MockCommunityRepository();
}

@riverpod
Future<List<Community>> myCommunities(Ref ref) {
  return ref.watch(communityRepositoryProvider).getMyCommunities();
}
