import 'package:flutter/material.dart';
import '../../features/qa/domain/answer.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'user_avatar.dart';
import 'vote_controls.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:flutter_animate/flutter_animate.dart';
import 'glass_card.dart';

class AnswerCard extends StatelessWidget {
  final Answer answer;

  const AnswerCard({
    super.key,
    required this.answer,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: GlassCard(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Left side: Votes
            Column(
              children: [
                VotePillar(
                  score: answer.upvotes,
                  isUpvoted: false, // TODO: Implement state
                  isDownvoted: false, // TODO: Implement state
                  onUpvote: () {},
                  onDownvote: () {},
                ),
                if (answer.isAccepted)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: Icon(Icons.check_circle, color: Colors.green, size: 28),
                  ),
              ],
            ),
            const SizedBox(width: 16),
            // Right side: Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Author & Time
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
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Content
                  Text(
                    answer.content,
                    style: AppTypography.bodyMd.copyWith(color: AppColors.onSurface),
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
