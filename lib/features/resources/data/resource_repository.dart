import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/resource.dart';

part 'resource_repository.g.dart';

abstract class ResourceRepository {
  Future<List<Resource>> getRecentResources();
  Future<List<Resource>> getResourcesByCommunity(String communityId);
  Future<Resource?> getResourceDetails(String resourceId);
  Future<void> addResource(Resource resource);
}

class MockResourceRepository implements ResourceRepository {
  final List<Resource> _mockResources = [
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
      sizeBytes: 120000,
      downloads: 89,
      upvotes: 21,
    ),
    Resource(
      id: 'r3',
      title: 'Linear Algebra Cheat Sheet & Formulae',
      type: 'PDF',
      uploaderId: 'u8',
      uploaderName: 'Elena Rostova',
      communityId: 'c3',
      communityName: 'Mathematics Club',
      uploadedAt: DateTime.now().subtract(const Duration(days: 1)),
      url: 'https://example.com/linear_algebra.pdf',
      sizeBytes: 1540000,
      downloads: 210,
      upvotes: 67,
    ),
  ];

  @override
  Future<List<Resource>> getRecentResources() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.unmodifiable(_mockResources);
  }

  @override
  Future<List<Resource>> getResourcesByCommunity(String communityId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_mockResources.where((r) => r.communityId == communityId).toList());
  }

  @override
  Future<Resource?> getResourceDetails(String resourceId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _mockResources.where((r) => r.id == resourceId).firstOrNull;
  }

  @override
  Future<void> addResource(Resource resource) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _mockResources.insert(0, resource);
  }
}

@Riverpod(keepAlive: true)
ResourceRepository resourceRepository(Ref ref) {
  return MockResourceRepository();
}

@riverpod
Future<List<Resource>> recentResources(Ref ref) {
  return ref.watch(resourceRepositoryProvider).getRecentResources();
}

@riverpod
Future<Resource?> resourceDetail(Ref ref, String resourceId) {
  return ref.watch(resourceRepositoryProvider).getResourceDetails(resourceId);
}

@riverpod
Future<List<Resource>> resourcesByCommunity(Ref ref, String communityId) {
  return ref.watch(resourceRepositoryProvider).getResourcesByCommunity(communityId);
}
