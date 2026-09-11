import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/resource_card.dart';
import '../../../core/widgets/premium_background.dart';
import '../data/resource_repository.dart';

class ResourcesScreen extends ConsumerWidget {
  const ResourcesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recentResourcesState = ref.watch(recentResourcesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PremiumBackground(
        child: recentResourcesState.when(
          data: (resources) {
            if (resources.isEmpty) {
              return const Center(child: Text('No resources found.'));
            }
            return ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              itemCount: resources.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Academic Resources',
                              style: AppTypography.headlineLg,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Notes, past papers, and study guides.',
                              style: AppTypography.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            // TODO: Upload Resource Action
                          },
                          icon: const Icon(Icons.upload),
                          label: const Text('Upload'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryContainer,
                            foregroundColor: AppColors.onPrimaryContainer,
                          ),
                        ),
                      ],
                    ),
                  );
                }
                final resource = resources[index - 1];
                return ResourceCard(
                  resource: resource,
                  onTap: () {
                    // TODO: Navigate to resource detail
                  },
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Text('Error loading resources: $error'),
          ),
        ),
      ),
    );
  }
}
