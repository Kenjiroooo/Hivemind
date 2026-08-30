import 'package:flutter/material.dart';
import '../theme/app_typography.dart';

class BadgeIcon extends StatelessWidget {
  final String badgeName;
  final double size;

  const BadgeIcon({
    super.key,
    required this.badgeName,
    this.size = 64.0,
  });

  @override
  Widget build(BuildContext context) {
    // Map badge names to colors and icons for MVP
    Color badgeColor;
    IconData badgeIcon;

    switch (badgeName.toLowerCase()) {
      case 'helpful':
        badgeColor = Colors.green;
        badgeIcon = Icons.thumb_up;
        break;
      case 'scholar':
        badgeColor = Colors.amber;
        badgeIcon = Icons.school;
        break;
      case 'founder':
        badgeColor = Colors.purple;
        badgeIcon = Icons.star;
        break;
      case 'expert':
        badgeColor = Colors.blue;
        badgeIcon = Icons.military_tech;
        break;
      default:
        badgeColor = Colors.grey;
        badgeIcon = Icons.emoji_events;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: badgeColor.withValues(alpha: 0.1),
            border: Border.all(color: badgeColor.withValues(alpha: 0.5), width: 2),
          ),
          child: Icon(
            badgeIcon,
            color: badgeColor,
            size: size * 0.5,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          badgeName,
          style: AppTypography.labelMd.copyWith(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
