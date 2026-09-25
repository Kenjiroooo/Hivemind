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
        // Upvote button with press animation
        _AnimatedVoteButton(
          icon: Icons.keyboard_arrow_up_rounded,
          isActive: isUpvoted,
          activeColor: AppColors.primary,
          size: 32,
          onTap: onUpvote,
        ),
        // Score with color transition
        AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: AppTypography.labelMd.copyWith(
            color: isUpvoted
                ? AppColors.primary
                : (isDownvoted ? AppColors.error : AppColors.onSurface),
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          child: Text('$score'),
        ),
        // Downvote button with press animation
        _AnimatedVoteButton(
          icon: Icons.keyboard_arrow_down_rounded,
          isActive: isDownvoted,
          activeColor: AppColors.error,
          size: 32,
          onTap: onDownvote,
        ),
      ],
    );
  }
}

class _AnimatedVoteButton extends StatefulWidget {
  final IconData icon;
  final bool isActive;
  final Color activeColor;
  final double size;
  final VoidCallback onTap;

  const _AnimatedVoteButton({
    required this.icon,
    required this.isActive,
    required this.activeColor,
    required this.size,
    required this.onTap,
  });

  @override
  State<_AnimatedVoteButton> createState() => _AnimatedVoteButtonState();
}

class _AnimatedVoteButtonState extends State<_AnimatedVoteButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.4), weight: 50),
      TweenSequenceItem(tween: Tween(begin: 1.4, end: 1.0), weight: 50),
    ]).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward(from: 0.0);
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        child: IconButton(
          onPressed: _handleTap,
          icon: Icon(
            widget.icon,
            color: widget.isActive ? widget.activeColor : AppColors.onSurfaceVariant,
            size: widget.size,
          ),
          splashRadius: 20,
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
        ),
      ),
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
          _AnimatedVoteButton(
            icon: Icons.keyboard_arrow_up_rounded,
            isActive: isUpvoted,
            activeColor: AppColors.primary,
            size: 24,
            onTap: onUpvote,
          ),
          const SizedBox(width: 4),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 200),
            style: AppTypography.bodySm.copyWith(
              color: isUpvoted
                  ? AppColors.primary
                  : (isDownvoted ? AppColors.error : AppColors.onSurface),
              fontWeight: FontWeight.bold,
            ),
            child: Text('$score'),
          ),
          const SizedBox(width: 4),
          _AnimatedVoteButton(
            icon: Icons.keyboard_arrow_down_rounded,
            isActive: isDownvoted,
            activeColor: AppColors.error,
            size: 24,
            onTap: onDownvote,
          ),
        ],
      ),
    );
  }
}
