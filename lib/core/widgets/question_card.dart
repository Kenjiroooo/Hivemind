import 'package:flutter/material.dart';
import '../../features/feed/domain/question.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'tag_chip.dart';
import 'user_avatar.dart';
import 'vote_controls.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'glass_card.dart';

class QuestionCard extends StatelessWidget {
  final Question question;
  final VoidCallback? onTap;

  const QuestionCard({
    super.key,
    required this.question,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: GestureDetector(
        onTap: onTap,
        child: GlassCard(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Left side: Votes
              VotePillar(
                score: question.upvotes,
                isUpvoted: false, // TODO: Implement state
                isDownvoted: false, // TODO: Implement state
                onUpvote: () {},
                onDownvote: () {},
              ),
              const SizedBox(width: 20),
              // Right side: Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Author & Time
                    Row(
                      children: [
                        UserAvatar(
                          imageUrl: question.authorPhotoUrl,
                          fallbackText: question.authorName,
                          size: 28,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          question.authorName,
                          style: AppTypography.labelMd.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurface,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '•',
                          style: AppTypography.labelMd.copyWith(color: AppColors.outline),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          timeago.format(question.createdAt),
                          style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    // Title
                    Text(
                      question.title,
                      style: AppTypography.headlineSm.copyWith(
                        color: AppColors.onSurface,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Snippet
                    Text(
                      question.content,
                      style: AppTypography.bodyMd.copyWith(
                        color: AppColors.onSurfaceVariant,
                        height: 1.6,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 20),
                    // Tags and Answers
                    Row(
                      children: [
                        Expanded(
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: question.tags
                                .map((tag) => TagChip(label: tag))
                                .toList(),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: question.isResolved 
                                ? AppColors.success.withValues(alpha: 0.1) 
                                : AppColors.surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(99),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                question.isResolved ? Icons.check_circle : Icons.chat_bubble_rounded,
                                size: 16,
                                color: question.isResolved ? AppColors.success : AppColors.onSurfaceVariant,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                '${question.answerCount} answers',
                                style: AppTypography.labelMd.copyWith(
                                  color: question.isResolved ? AppColors.success : AppColors.onSurfaceVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.05, end: 0, duration: 400.ms, curve: Curves.easeOutQuad);
  }
}
