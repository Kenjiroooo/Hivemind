import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/question_card.dart';
import '../../../core/widgets/answer_card.dart';
import '../application/qa_service.dart';
import 'widgets/ai_summary_card.dart';

class QuestionDetailScreen extends ConsumerWidget {
  final String questionId;

  const QuestionDetailScreen({
    super.key,
    required this.questionId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final questionState = ref.watch(questionDetailProvider(questionId));
    final answersState = ref.watch(questionAnswersProvider(questionId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Question Details'),
      ),
      body: questionState.when(
        data: (question) {
          if (question == null) {
            return const Center(child: Text('Question not found.'));
          }
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      QuestionCard(question: question),
                      const SizedBox(height: 16),
                      const AISummaryCard(
                        summary: 'The community suggests using **logic gates** to implement this. Key takeaways:\n- Use an AND gate for combining conditions.\n- An inverter (NOT gate) is needed for the inverted signal.\n- Review Chapter 4 of the textbook for Karnaugh Maps.',
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'Answers (${question.answerCount})',
                        style: AppTypography.headlineSm,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              answersState.when(
                data: (answers) {
                  return SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => AnswerCard(answer: answers[index]),
                        childCount: answers.length,
                      ),
                    ),
                  );
                },
                loading: () => const SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                ),
                error: (error, stack) => SliverToBoxAdapter(
                  child: Center(child: Text('Error loading answers: $error')),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(height: 100), // padding for FAB
              )
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading question: $error'),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // TODO: Implement answer drafting logic
        },
        label: const Text('Write Answer'),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
