import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class VotePillar extends StatelessWidget {
  final int score;
  final bool isUpvoted;
  final bool isDownvoted;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;

  const VotePillar({
    super.key,
    required this.score,
    required this.isUpvoted,
    required this.isDownvoted,
    required this.onUpvote,
    required this.onDownvote,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: onUpvote,
          icon: Icon(
            Icons.keyboard_arrow_up_rounded,
            color: isUpvoted ? AppColors.primary : AppColors.onSurfaceVariant,
            size: 32,
          ),
          splashRadius: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
        Text(
          '$score',
          style: AppTypography.labelMd.copyWith(
            color: isUpvoted
                ? AppColors.primary
                : (isDownvoted ? AppColors.error : AppColors.onSurface),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        IconButton(
          onPressed: onDownvote,
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: isDownvoted ? AppColors.error : AppColors.onSurfaceVariant,
            size: 32,
          ),
          splashRadius: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ],
    );
  }
}

class VoteInline extends StatelessWidget {
  final int score;
  final bool isUpvoted;
  final bool isDownvoted;
  final VoidCallback onUpvote;
  final VoidCallback onDownvote;

  const VoteInline({
    super.key,
    required this.score,
    required this.isUpvoted,
    required this.isDownvoted,
    required this.onUpvote,
    required this.onDownvote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(9999),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            onPressed: onUpvote,
            icon: Icon(
              Icons.keyboard_arrow_up_rounded,
              color: isUpvoted ? AppColors.primary : AppColors.onSurfaceVariant,
              size: 24,
            ),
            splashRadius: 16,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          ),
          const SizedBox(width: 4),
          Text(
            '$score',
            style: AppTypography.bodySm.copyWith(
              color: isUpvoted
                  ? AppColors.primary
                  : (isDownvoted ? AppColors.error : AppColors.onSurface),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 4),
          IconButton(
            onPressed: onDownvote,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: isDownvoted ? AppColors.error : AppColors.onSurfaceVariant,
              size: 24,
            ),
            splashRadius: 16,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          ),
        ],
      ),
    );
  }
}
