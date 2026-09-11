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
    final resourceFuture = ref.watch(resourceRepositoryProvider).getResourceDetails(resourceId);

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
        child: FutureBuilder(
        future: resourceFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final resource = snapshot.data;
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
                  'This is a mock description for the resource. In the final version, this will display the full text or metadata provided by the uploader.',
                  style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                ),
                const SizedBox(height: 32),
                Center(
                  child: PrimaryButton(
                    onPressed: () {
                      // TODO: Download logic
                    },
                    icon: Icons.download,
                    label: 'Download File (${(resource.sizeBytes / 1024 / 1024).toStringAsFixed(2)} MB)',
                  ),
                ),
              ],
            ),
          );
        },
      ),
      ),
    );
  }
}
