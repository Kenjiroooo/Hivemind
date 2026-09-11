import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/question_card.dart';
import '../../../core/widgets/premium_background.dart';
import '../application/feed_service.dart';

class ExploreScreen extends ConsumerWidget {
  final String? category;
  
  const ExploreScreen({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingFeedState = ref.watch(trendingFeedProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: trendingFeedState.when(
          data: (allQuestions) {
            final questions = category == null 
                ? allQuestions 
                : allQuestions.where((q) => q.tags.contains(category)).toList();
                
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              itemCount: questions.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category != null ? 'Explore: $category' : 'Explore Hivemind',
                          style: AppTypography.headlineLg,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          category != null 
                              ? 'Discussions and resources related to $category.'
                              : 'Trending discussions and top resources across the university.',
                          style: AppTypography.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                  );
                }
                
                if (questions.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Text('No questions found for $category yet.', style: AppTypography.bodyLg),
                    ),
                  );
                }
                
                final question = questions[index - 1];
                return QuestionCard(
                  question: question,
                  onTap: () {
                    context.push('/question/${question.id}');
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error loading feed: $error'),
          ),
        ),
      ),
    );
  }
}
