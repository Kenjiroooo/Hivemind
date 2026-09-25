import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../feed/domain/question.dart';
import '../domain/answer.dart';
import '../../feed/data/feed_repository.dart';

part 'qa_repository.g.dart';

abstract class QARepository {
  Future<Question?> getQuestionDetails(String questionId);
  Future<List<Answer>> getAnswersForQuestion(String questionId);
  Future<void> submitQuestion(String title, String content, List<String> tags);
  Future<void> submitAnswer(String questionId, String content);
  Future<void> acceptAnswer(String questionId, String answerId);
}

class MockQARepository implements QARepository {
  final Ref ref;

  MockQARepository(this.ref);

  /// Mutable per-question answers map. Allows new answers to be posted.
  final Map<String, List<Answer>> _answersMap = {
    'q1': [
      Answer(
        id: 'a1',
        questionId: 'q1',
        content:
            "You should look for octets first, as grouping by 8 will eliminate 3 variables. If you can't find octets, look for quads (eliminates 2 variables), then pairs (eliminates 1 variable). Always try to make the groups as large as possible, even if they overlap with other groups!",
        authorId: 'u9',
        authorName: 'Dr. Emily Chen',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        upvotes: 24,
        isAccepted: true,
      ),
      Answer(
        id: 'a2',
        questionId: 'q1',
        content:
            "Don't forget about the \"don't care\" conditions! If you have any Xs in your truth table, you can include them in your groups if it helps make a larger group (like turning a quad into an octet). If an X doesn't help make a larger group, just ignore it.",
        authorId: 'u12',
        authorName: 'Sam Rodgers',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        upvotes: 8,
      ),
    ],
    'q2': [
      Answer(
        id: 'a3',
        questionId: 'q2',
        content:
            'The worst case for QuickSort is **O(N²)**. This happens when the pivot is consistently chosen as the smallest or largest element — for example, on an already sorted array with a naive pivot selection (e.g., always picking the first element). To mitigate this, use a randomized pivot or the "median of three" strategy.',
        authorId: 'u9',
        authorName: 'Dr. Emily Chen',
        createdAt: DateTime.now().subtract(const Duration(hours: 3)),
        upvotes: 89,
        isAccepted: true,
      ),
    ],
    'q3': [
      Answer(
        id: 'a4',
        questionId: 'q3',
        content:
            'You need to apply your auth middleware selectively. Use `router.use(\'/api\', authMiddleware)` for protected routes. For public routes like `/login`, either place them before the middleware declaration or create a separate public router.',
        authorId: 'u5',
        authorName: 'Alex Kim',
        createdAt: DateTime.now().subtract(const Duration(minutes: 20)),
        upvotes: 5,
      ),
    ],
  };

  @override
  Future<Question?> getQuestionDetails(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 500));

    // Search across home feed and trending questions
    final feedRepo = ref.read(feedRepositoryProvider);
    final homeQuestions = await feedRepo.getHomeFeed();
    final trendingQuestions = await feedRepo.getTrendingQuestions();

    return [...homeQuestions, ...trendingQuestions]
        .where((q) => q.id == questionId)
        .firstOrNull;
  }

  @override
  Future<List<Answer>> getAnswersForQuestion(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 800));
    return List.unmodifiable(_answersMap[questionId] ?? []);
  }

  @override
  Future<void> submitQuestion(String title, String content, List<String> tags) async {
    // Handled in ask_question_screen using feedRepository directly
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> submitAnswer(String questionId, String content) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simulate network
    final newAnswer = Answer(
      id: 'a_${DateTime.now().millisecondsSinceEpoch}',
      questionId: questionId,
      content: content,
      authorId: 'u1', // current user — will be replaced with real auth later
      authorName: 'You',
      createdAt: DateTime.now(),
      upvotes: 0,
    );

    if (_answersMap.containsKey(questionId)) {
      _answersMap[questionId]!.add(newAnswer);
    } else {
      _answersMap[questionId] = [newAnswer];
    }
  }

  @override
  Future<void> acceptAnswer(String questionId, String answerId) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final answers = _answersMap[questionId];
    if (answers != null) {
      _answersMap[questionId] = answers.map((a) {
        if (a.id == answerId) {
          return a.copyWith(isAccepted: !a.isAccepted);
        }
        return a.copyWith(isAccepted: false);
      }).toList();
    }
  }
}

@riverpod
QARepository qaRepository(Ref ref) {
  return MockQARepository(ref);
}
