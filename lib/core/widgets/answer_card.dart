import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../features/qa/domain/answer.dart';
import '../providers/vote_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'user_avatar.dart';
import 'vote_controls.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_animate/flutter_animate.dart';
import 'glass_card.dart';

class AnswerCard extends ConsumerWidget {
  final Answer answer;
  final bool isQuestionAuthor;
  final VoidCallback? onAccept;

  const AnswerCard({
    super.key,
    required this.answer,
    this.isQuestionAuthor = false,
    this.onAccept,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voteState = ref.watch(voteProvider);
    final direction = voteState.directionFor(answer.id);
    final adjustedScore = voteState.adjustedScore(answer.id, answer.upvotes);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side: Votes + accepted icon
            Column(
              children: [
                VotePillar(
                  score: adjustedScore,
                  isUpvoted: direction == VoteDirection.up,
                  isDownvoted: direction == VoteDirection.down,
                  onUpvote: () => ref.read(voteProvider.notifier).toggleUpvote(answer.id),
                  onDownvote: () => ref.read(voteProvider.notifier).toggleDownvote(answer.id),
                ),
                if (answer.isAccepted && !isQuestionAuthor)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Tooltip(
                      message: 'Accepted Answer',
                      child: const Icon(Icons.check_circle, color: Colors.green, size: 28),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Right side: Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author & Time & Accept action
                  Row(
                    children: [
                      UserAvatar(
                        imageUrl: answer.authorPhotoUrl,
                        fallbackText: answer.authorName,
                        size: 24,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        answer.authorName,
                        style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '•',
                        style: AppTypography.labelMd.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        timeago.format(answer.createdAt),
                        style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                      ),
                      const Spacer(),
                      if (isQuestionAuthor)
                        InkWell(
                          onTap: onAccept,
                          borderRadius: BorderRadius.circular(99),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: answer.isAccepted
                                  ? AppColors.success.withValues(alpha: 0.15)
                                  : AppColors.surfaceContainerHigh,
                              border: Border.all(
                                color: answer.isAccepted ? AppColors.success : AppColors.outline.withValues(alpha: 0.3),
                              ),
                              borderRadius: BorderRadius.circular(99),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  answer.isAccepted ? Icons.check_circle : Icons.check_circle_outline,
                                  size: 14,
                                  color: answer.isAccepted ? AppColors.success : AppColors.onSurfaceVariant,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  answer.isAccepted ? 'Accepted' : 'Accept',
                                  style: AppTypography.labelMd.copyWith(
                                    color: answer.isAccepted ? AppColors.success : AppColors.onSurfaceVariant,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else if (answer.isAccepted)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.success.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.check, size: 12, color: AppColors.success),
                              const SizedBox(width: 4),
                              Text(
                                'Accepted',
                                style: AppTypography.labelMd.copyWith(
                                  color: AppColors.success,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Content with Markdown rendering
                  MarkdownBody(
                    data: answer.content,
                    selectable: true,
                    styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
                      p: AppTypography.bodyMd.copyWith(color: AppColors.onSurface),
                      code: TextStyle(
                        backgroundColor: AppColors.surfaceContainerHigh,
                        fontFamily: 'monospace',
                        fontSize: 13,
                        color: AppColors.primary,
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0, duration: 400.ms, curve: Curves.easeOutQuad);
  }
}
