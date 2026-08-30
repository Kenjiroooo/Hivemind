import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/question_card.dart';
import '../application/feed_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeFeedState = ref.watch(homeFeedProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: homeFeedState.when(
        data: (questions) {
          if (questions.isEmpty) {
            return const Center(child: Text('No questions found.'));
          }
          return RefreshIndicator(
            onRefresh: () => ref.read(homeFeedProvider.notifier).refresh(),
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              itemCount: questions.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Your Feed',
                              style: AppTypography.headlineLg,
                            ),
                            IconButton(
                              icon: const Icon(Icons.notifications_none),
                              onPressed: () => context.push('/notifications'),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Recent activity from your communities and interests.',
                          style: AppTypography.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                      ],
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
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading feed: $error'),
        ),
      ),
    );
  }
}
