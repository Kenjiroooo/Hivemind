import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_typography.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AISummaryCard extends StatelessWidget {
  final String? summary;
  final bool isLoading;

  const AISummaryCard({
    super.key,
    this.summary,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16.0),
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                const Icon(Icons.auto_awesome, color: Colors.blue, size: 20),
                const SizedBox(width: 8),
                Text(
                  'AI Summary',
                  style: AppTypography.labelMd.copyWith(
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                if (isLoading)
                  const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2, color: Colors.blue),
                  )
                else
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.blue.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(99),
                    ),
                    child: Text(
                      'Auto-generated',
                      style: AppTypography.labelMd.copyWith(
                        color: Colors.blue.shade700,
                        fontSize: 11,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildContent(),
          ),
        ],
      ),
    ).animate().fadeIn(duration: 400.ms);
  }

  Widget _buildContent() {
    if (isLoading) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _shimmerLine(width: double.infinity),
          const SizedBox(height: 8),
          _shimmerLine(width: 280),
          const SizedBox(height: 8),
          _shimmerLine(width: 240),
        ],
      );
    }

    if (summary == null || summary!.trim().isEmpty) {
      return Row(
        children: [
          Icon(Icons.info_outline, size: 16, color: Colors.blue.shade400),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'No AI summary is available for this question yet.',
              style: AppTypography.bodyMd.copyWith(color: Colors.blue.shade400),
            ),
          ),
        ],
      );
    }

    return MarkdownBody(
      data: summary!,
      styleSheet: MarkdownStyleSheet(
        p: AppTypography.bodyMd.copyWith(color: AppColors.onSurface),
        strong: AppTypography.bodyMd.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.onSurface,
        ),
        tableHead: AppTypography.labelMd.copyWith(fontWeight: FontWeight.bold),
        tableBody: AppTypography.bodyMd,
        code: AppTypography.bodyMd.copyWith(
          fontFamily: 'monospace',
          backgroundColor: AppColors.surfaceContainerHigh,
        ),
      ),
    );
  }

  Widget _shimmerLine({required double width}) {
    return Container(
      width: width,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.blue.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(6),
      ),
    ).animate(onPlay: (c) => c.repeat()).shimmer(
      duration: 1200.ms,
      color: Colors.blue.withValues(alpha: 0.3),
    );
  }
}
