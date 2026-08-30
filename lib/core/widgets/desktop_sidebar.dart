import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

import 'package:flutter_animate/flutter_animate.dart';

class DesktopSidebar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabSelected;
  final String userName;

  const DesktopSidebar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.only(right: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good evening, $userName 👋',
                  style: AppTypography.headlineSm.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'What are you learning today?',
                  style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
          
          _buildSearchBar(),
          const SizedBox(height: 32),
          
          Text(
            'CATEGORIES',
            style: AppTypography.labelMd.copyWith(color: AppColors.outline),
          ),
          const SizedBox(height: 16),
          
          _buildNavItem(0, 'For You', Icons.local_fire_department, isHighlighted: true),
          _buildNavItem(1, 'CPE', Icons.memory),
          _buildNavItem(2, 'Programming', Icons.code),
          _buildNavItem(3, 'Electronics', Icons.electrical_services),
          _buildNavItem(4, 'Mathematics', Icons.calculate),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outlineVariant.withValues(alpha: 0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          hintText: 'Search questions, subjects...',
          prefixIcon: Icon(Icons.search, color: AppColors.outline),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon, {bool isHighlighted = false}) {
    final isSelected = currentIndex == index;
    
    Widget item = Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => onTabSelected(index),
        borderRadius: BorderRadius.circular(12),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            gradient: (isSelected || isHighlighted) ? AppColors.primaryGradient : null,
            color: (!isSelected && !isHighlighted) ? Colors.transparent : null,
            borderRadius: BorderRadius.circular(12),
            boxShadow: (isSelected || isHighlighted)
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.25),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    )
                  ]
                : [],
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: (isSelected || isHighlighted) 
                    ? Colors.white 
                    : AppColors.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: AppTypography.bodyMd.copyWith(
                  color: (isSelected || isHighlighted) 
                      ? Colors.white 
                      : AppColors.onSurfaceVariant,
                  fontWeight: (isSelected || isHighlighted) 
                      ? FontWeight.bold 
                      : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );

    if (isSelected || isHighlighted) {
      item = item.animate().slideX(begin: -0.05, end: 0, duration: 300.ms, curve: Curves.easeOutCubic);
    }

    return item;
  }
}
