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
}

class MockQARepository implements QARepository {
  final Ref ref;

  MockQARepository(this.ref);

  @override
  Future<Question?> getQuestionDetails(String questionId) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    // For mock purposes, search in the mock feed repo
    final feedRepo = ref.read(feedRepositoryProvider);
    final homeQuestions = await feedRepo.getHomeFeed();
    final trendingQuestions = await feedRepo.getTrendingQuestions();
    
    return [...homeQuestions, ...trendingQuestions]
        .where((q) => q.id == questionId)
        .firstOrNull;
  }

  @override
  Future<List<Answer>> getAnswersForQuestion(String questionId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Answer(
        id: 'a1',
        questionId: questionId,
        content: 'You should look for octets first, as grouping by 8 will eliminate 3 variables. If you can\'t find octets, look for quads (eliminates 2 variables), then pairs (eliminates 1 variable). Always try to make the groups as large as possible, even if they overlap with other groups!',
        authorId: 'u9',
        authorName: 'Dr. Emily Chen',
        createdAt: DateTime.now().subtract(const Duration(hours: 1)),
        upvotes: 24,
        isAccepted: true,
      ),
      Answer(
        id: 'a2',
        questionId: questionId,
        content: 'Don\'t forget about the "don\'t care" conditions! If you have any Xs in your truth table, you can include them in your groups if it helps make a larger group (like turning a quad into an octet). If an X doesn\'t help make a larger group, just ignore it.',
        authorId: 'u12',
        authorName: 'Sam Rodgers',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        upvotes: 8,
      ),
    ];
  }

  @override
  Future<void> submitQuestion(String title, String content, List<String> tags) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, this would post to backend
  }

  @override
  Future<void> submitAnswer(String questionId, String content) async {
    await Future.delayed(const Duration(seconds: 1));
    // In a real app, this would post to backend
  }
}

@riverpod
QARepository qaRepository(Ref ref) {
  return MockQARepository(ref);
}
