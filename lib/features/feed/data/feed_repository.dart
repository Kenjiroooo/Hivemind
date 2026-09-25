import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/question.dart';

part 'feed_repository.g.dart';

abstract class FeedRepository {
  Future<List<Question>> getHomeFeed({int limit = 10, String? cursor});
  Future<List<Question>> getTrendingQuestions({int limit = 5});
  Future<void> addQuestion(Question question);
}

class MockFeedRepository implements FeedRepository {
  // Mutable in-memory list — supports adding new questions for the session
  final List<Question> _questions = [
    Question(
      id: 'q1',
      title: 'How do you simplify this K-map?',
      content:
          "I'm currently working on a digital logic design assignment and I'm stuck on this 4-variable Karnaugh map. I've populated the 1s based on my truth table, but I'm unsure if I'm grouping them optimally to get the most simplified boolean expression.\n\nShould I be looking for octets here, or am I limited to quads?",
      authorId: 'u2',
      authorName: 'Mark Reyes',
      authorPhotoUrl: 'https://i.pravatar.cc/150?u=mark',
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      tags: ['DigitalLogic', 'KMap', 'CPE'],
      upvotes: 42,
      answerCount: 3,
    ),
    Question(
      id: 'q2',
      title: 'What is the time complexity of QuickSort in the worst case?',
      content:
          'I know the average case is O(N log N), but what triggers the worst case and what is the Big-O notation for it?',
      authorId: 'u3',
      authorName: 'Sarah Jenkins',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      tags: ['Algorithms', 'CS102'],
      upvotes: 128,
      answerCount: 15,
      isResolved: true,
    ),
    Question(
      id: 'q3',
      title: 'Need help with Node.js Express middleware routing',
      content:
          'My custom authentication middleware is blocking all routes, even the public ones like /login. How do I selectively apply middleware to specific route groups?',
      authorId: 'u4',
      authorName: 'David Chen',
      authorPhotoUrl: 'https://i.pravatar.cc/150?u=david',
      createdAt: DateTime.now().subtract(const Duration(minutes: 45)),
      tags: ['WebDev', 'NodeJS', 'Express'],
      upvotes: 15,
      answerCount: 1,
    ),
  ];

  @override
  Future<List<Question>> getHomeFeed({int limit = 10, String? cursor}) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network latency
    return List.unmodifiable(_questions);
  }

  @override
  Future<List<Question>> getTrendingQuestions({int limit = 5}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return [
      Question(
        id: 't1',
        title: 'Final Exam Review Sheet - CS301',
        content: 'Sharing my compiled notes for the upcoming final...',
        authorId: 'u5',
        authorName: 'Alex Smith',
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
        tags: ['CS301', 'Review'],
        upvotes: 342,
        answerCount: 22,
      ),
    ];
  }

  @override
  Future<void> addQuestion(Question question) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Simulate write
    _questions.insert(0, question); // New questions appear at top of feed
  }
}

@Riverpod(keepAlive: true)
FeedRepository feedRepository(Ref ref) {
  return MockFeedRepository();
}
