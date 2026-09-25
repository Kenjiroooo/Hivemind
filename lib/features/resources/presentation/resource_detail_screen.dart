import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/resource_card.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/premium_background.dart';
import '../data/resource_repository.dart';

class ResourceDetailScreen extends ConsumerWidget {
  final String resourceId;

  const ResourceDetailScreen({
    super.key,
    required this.resourceId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resourceState = ref.watch(resourceDetailProvider(resourceId));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Resource Details'),
      ),
      body: PremiumBackground(
        child: resourceState.when(
          data: (resource) {
            if (resource == null) {
              return const Center(child: Text('Resource not found.'));
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ResourceCard(resource: resource),
                  const SizedBox(height: 24),
                  Text(
                    'About this resource',
                    style: AppTypography.headlineSm,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Shared in ${resource.communityName} by ${resource.uploaderName}. Download or bookmark this material to prepare for midterms, quizzes, and project reviews.',
                    style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 32),
                  Center(
                    child: PrimaryButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                const Icon(Icons.download_done, color: Colors.white),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text('Downloading "${resource.title}"...'),
                                ),
                              ],
                            ),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: AppColors.primary,
                          ),
                        );
                      },
                      icon: Icons.download,
                      label: 'Download File (${(resource.sizeBytes / 1024 / 1024).toStringAsFixed(2)} MB)',
                    ),
                  ),
                ],
              ),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Error loading resource: $error')),
        ),
      ),
    );
  }
}
