import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../feed/domain/question.dart';
import '../domain/answer.dart';
import '../data/qa_repository.dart';

part 'qa_service.g.dart';

@riverpod
Future<Question?> questionDetail(Ref ref, String questionId) {
  return ref.watch(qaRepositoryProvider).getQuestionDetails(questionId);
}

@riverpod
Future<List<Answer>> questionAnswers(Ref ref, String questionId) {
  return ref.watch(qaRepositoryProvider).getAnswersForQuestion(questionId);
}
