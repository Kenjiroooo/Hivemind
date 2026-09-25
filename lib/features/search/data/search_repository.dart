import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../feed/data/feed_repository.dart';
import '../../feed/domain/question.dart';
import '../../resources/data/resource_repository.dart';
import '../../resources/domain/resource.dart';

part 'search_repository.g.dart';

class SearchResults {
  final List<Question> questions;
  final List<Resource> resources;

  const SearchResults({
    this.questions = const [],
    this.resources = const [],
  });

  bool get isEmpty => questions.isEmpty && resources.isEmpty;
  int get totalCount => questions.length + resources.length;
}

abstract class SearchRepository {
  Future<SearchResults> search(String query);
}

class MockSearchRepository implements SearchRepository {
  final Ref ref;

  MockSearchRepository(this.ref);

  @override
  Future<SearchResults> search(String query) async {
    final clean = query.trim().toLowerCase();
    if (clean.isEmpty) {
      return const SearchResults();
    }

    await Future.delayed(const Duration(milliseconds: 300)); // Debounce simulation

    final feedRepo = ref.read(feedRepositoryProvider);
    final homeFeed = await feedRepo.getHomeFeed();
    final trending = await feedRepo.getTrendingQuestions();
    
    // De-duplicate questions
    final questionMap = <String, Question>{};
    for (final q in [...homeFeed, ...trending]) {
      questionMap[q.id] = q;
    }

    final matchedQuestions = questionMap.values.where((q) {
      final inTitle = q.title.toLowerCase().contains(clean);
      final inContent = q.content.toLowerCase().contains(clean);
      final inTags = q.tags.any((t) => t.toLowerCase().contains(clean));
      final inAuthor = q.authorName.toLowerCase().contains(clean);
      return inTitle || inContent || inTags || inAuthor;
    }).toList();

    final resourceRepo = ref.read(resourceRepositoryProvider);
    final allResources = await resourceRepo.getRecentResources();
    final matchedResources = allResources.where((r) {
      final inTitle = r.title.toLowerCase().contains(clean);
      final inType = r.type.toLowerCase().contains(clean);
      final inComm = r.communityName.toLowerCase().contains(clean);
      return inTitle || inType || inComm;
    }).toList();

    return SearchResults(
      questions: matchedQuestions,
      resources: matchedResources,
    );
  }
}

@riverpod
SearchRepository searchRepository(Ref ref) {
  return MockSearchRepository(ref);
}

@riverpod
Future<SearchResults> searchResults(Ref ref, String query) {
  return ref.watch(searchRepositoryProvider).search(query);
}
