import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/resource.dart';

part 'resource_repository.g.dart';

abstract class ResourceRepository {
  Future<List<Resource>> getRecentResources();
  Future<List<Resource>> getResourcesByCommunity(String communityId);
  Future<Resource?> getResourceDetails(String resourceId);
}

class MockResourceRepository implements ResourceRepository {
  @override
  Future<List<Resource>> getRecentResources() async {
    await Future.delayed(const Duration(seconds: 1));
    return _mockResources;
  }

  @override
  Future<List<Resource>> getResourcesByCommunity(String communityId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockResources.where((r) => r.communityId == communityId).toList();
  }

  @override
  Future<Resource?> getResourceDetails(String resourceId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _mockResources.where((r) => r.id == resourceId).firstOrNull;
  }

  final _mockResources = [
    Resource(
      id: 'r1',
      title: 'Digital Logic Midterm Review Notes.pdf',
      type: 'PDF',
      uploaderId: 'u12',
      uploaderName: 'Sam Rodgers',
      communityId: 'c1',
      communityName: 'CPE3A Class Space',
      uploadedAt: DateTime.now().subtract(const Duration(days: 2)),
      url: 'https://example.com/mock.pdf',
      sizeBytes: 2400000,
      downloads: 142,
      upvotes: 45,
    ),
    Resource(
      id: 'r2',
      title: 'Arduino Sensor Interfacing Guide',
      type: 'Link',
      uploaderId: 'u5',
      uploaderName: 'Prof. Davis',
      communityId: 'c2',
      communityName: 'Electronics Community',
      uploadedAt: DateTime.now().subtract(const Duration(days: 5)),
      url: 'https://example.com/guide',
      downloads: 89,
      upvotes: 21,
    ),
  ];
}

@riverpod
ResourceRepository resourceRepository(Ref ref) {
  return MockResourceRepository();
}

@riverpod
Future<List<Resource>> recentResources(Ref ref) {
  return ref.watch(resourceRepositoryProvider).getRecentResources();
}
