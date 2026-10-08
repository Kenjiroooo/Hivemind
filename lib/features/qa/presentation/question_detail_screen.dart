import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/question_card.dart';
import '../../../core/widgets/answer_card.dart';
import '../../../core/widgets/premium_background.dart';
import '../../auth/application/auth_service.dart';
import '../data/qa_repository.dart';
import '../application/qa_service.dart';
import '../application/ai_summary_provider.dart';
import '../../../core/providers/token_provider.dart';
import 'widgets/ai_summary_card.dart';
import 'widgets/answer_bottom_sheet.dart';

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
    final aiSummaryState = ref.watch(aiSummaryProvider(questionId));
    final currentUser = ref.watch(authControllerProvider).value;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Question Details'),
      ),
      body: PremiumBackground(
        child: questionState.when(
          data: (question) {
            if (question == null) {
              return const Center(child: Text('Question not found.'));
            }
            final isAuthor = currentUser != null && currentUser.id == question.authorId;

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QuestionCard(
                          question: question,
                          showFullContent: true,
                        ),
                        const SizedBox(height: 16),

                        // Dynamic AI Summary card
                        aiSummaryState.when(
                          data: (summary) => AISummaryCard(summary: summary),
                          loading: () => const AISummaryCard(isLoading: true),
                          error: (e, st) => const SizedBox.shrink(),
                        ),

                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Answers (${question.answerCount})',
                              style: AppTypography.headlineSm,
                            ),
                            answersState.whenData((answers) {
                              final acceptedCount =
                                  answers.where((a) => a.isAccepted).length;
                              if (acceptedCount > 0) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: AppColors.success
                                        .withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(99),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(Icons.check_circle,
                                          size: 14,
                                          color: AppColors.success),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Resolved',
                                        style: AppTypography.labelMd.copyWith(
                                          color: AppColors.success,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            }).value ?? const SizedBox.shrink(),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                answersState.when(
                  data: (answers) {
                    if (answers.isEmpty) {
                      return SliverToBoxAdapter(
                        child: Padding(
                          padding: const EdgeInsets.all(32.0),
                          child: Column(
                            children: [
                              Icon(Icons.chat_bubble_outline,
                                  size: 48,
                                  color: AppColors.onSurfaceVariant
                                      .withValues(alpha: 0.5)),
                              const SizedBox(height: 16),
                              Text(
                                'No answers yet.',
                                style: AppTypography.bodyLg.copyWith(
                                    color: AppColors.onSurfaceVariant),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Be the first to help!',
                                style: AppTypography.bodyMd.copyWith(
                                    color: AppColors.onSurfaceVariant
                                        .withValues(alpha: 0.7)),
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                    return SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => AnswerCard(
                            answer: answers[index],
                            isQuestionAuthor: isAuthor,
                            onAccept: () async {
                              final answer = answers[index];
                              
                              await ref
                                  .read(qaRepositoryProvider)
                                  .acceptAnswer(questionId, answer.id);
                              
                              if (!answer.isAccepted) {
                                ref.read(tokenControllerProvider.notifier).addTokens(50, reason: 'Best Answer');
                                ScaffoldMessenger.of(context).clearSnackBars();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: const Text('🎉 +50 Tokens awarded to the author for the Best Answer!'),
                                    backgroundColor: AppColors.primary,
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 4),
                                  ),
                                );
                              }

                              ref.invalidate(questionAnswersProvider(questionId));
                              ref.invalidate(questionDetailProvider(questionId));
                            },
                          ),
                          childCount: answers.length,
                        ),
                      ),
                    );
                  },
                  loading: () => const SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                  error: (error, stack) => SliverToBoxAdapter(
                    child:
                        Center(child: Text('Error loading answers: $error')),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 100), // padding for FAB
                ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error loading question: $error'),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (_) => AnswerBottomSheet(questionId: questionId),
          );
        },
        label: const Text('Write Answer'),
        icon: const Icon(Icons.edit),
      ),
    );
  }
}
