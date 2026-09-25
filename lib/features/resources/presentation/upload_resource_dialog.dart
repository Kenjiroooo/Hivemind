import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/buttons.dart';
import '../../auth/application/auth_service.dart';
import '../../communities/data/community_repository.dart';
import '../../communities/domain/community.dart';
import '../data/resource_repository.dart';
import '../domain/resource.dart';

class UploadResourceDialog extends ConsumerStatefulWidget {
  final String? preselectedCommunityId;

  const UploadResourceDialog({super.key, this.preselectedCommunityId});

  @override
  ConsumerState<UploadResourceDialog> createState() => _UploadResourceDialogState();
}

class _UploadResourceDialogState extends ConsumerState<UploadResourceDialog> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _urlController = TextEditingController();
  String _selectedType = 'PDF';
  String? _selectedCommunityId;
  bool _isSubmitting = false;

  final List<String> _resourceTypes = ['PDF', 'Link', 'Note', 'Video'];

  @override
  void initState() {
    super.initState();
    _selectedCommunityId = widget.preselectedCommunityId;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _submit(List<Community> communities) async {
    if (!_formKey.currentState!.validate()) return;
    if (_selectedCommunityId == null && communities.isNotEmpty) {
      _selectedCommunityId = communities.first.id;
    }

    final community = communities.firstWhere(
      (c) => c.id == _selectedCommunityId,
      orElse: () => communities.first,
    );

    setState(() => _isSubmitting = true);
    try {
      final currentUser = ref.read(authControllerProvider).value;
      final newResource = Resource(
        id: 'r_${DateTime.now().millisecondsSinceEpoch}',
        title: _titleController.text.trim(),
        type: _selectedType,
        uploaderId: currentUser?.id ?? 'u1',
        uploaderName: currentUser?.displayName ?? 'You',
        communityId: community.id,
        communityName: community.name,
        uploadedAt: DateTime.now(),
        url: _urlController.text.trim(),
        sizeBytes: 1850000,
        downloads: 0,
        upvotes: 0,
      );

      await ref.read(resourceRepositoryProvider).addResource(newResource);
      ref.invalidate(recentResourcesProvider);
      ref.invalidate(resourcesByCommunityProvider(community.id));

      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(Icons.check_circle, color: Colors.white),
                const SizedBox(width: 8),
                Text('Resource "${newResource.title}" uploaded!'),
              ],
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to upload resource: $e'),
            backgroundColor: AppColors.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final communitiesAsync = ref.watch(allCommunitiesProvider);

    return Dialog(
      backgroundColor: AppColors.surface,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: communitiesAsync.when(
            data: (communities) {
              if (_selectedCommunityId == null && communities.isNotEmpty) {
                _selectedCommunityId = communities.first.id;
              }

              return Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Upload Resource', style: AppTypography.headlineSm),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Title Field
                      TextFormField(
                        controller: _titleController,
                        decoration: InputDecoration(
                          labelText: 'Resource Title',
                          hintText: 'e.g. Midterm Cheat Sheet.pdf',
                          prefixIcon: const Icon(Icons.description_outlined),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a title';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Type Selector & Community Selector
                      Row(
                        children: [
                          Expanded(
                            flex: 2,
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedType,
                              decoration: InputDecoration(
                                labelText: 'Type',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              ),
                              items: _resourceTypes
                                  .map((type) => DropdownMenuItem(value: type, child: Text(type)))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedType = val);
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            flex: 3,
                            child: DropdownButtonFormField<String>(
                              initialValue: _selectedCommunityId,
                              decoration: InputDecoration(
                                labelText: 'Community',
                                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                              ),
                              items: communities
                                  .map((c) => DropdownMenuItem(
                                        value: c.id,
                                        child: Text(
                                          c.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ))
                                  .toList(),
                              onChanged: (val) {
                                if (val != null) setState(() => _selectedCommunityId = val);
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // URL Field
                      TextFormField(
                        controller: _urlController,
                        decoration: InputDecoration(
                          labelText: 'URL or File Link',
                          hintText: 'https://...',
                          prefixIcon: const Icon(Icons.link_rounded),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Please enter a URL';
                          }
                          if (!value.startsWith('http://') && !value.startsWith('https://')) {
                            return 'URL must start with http:// or https://';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 24),

                      // Actions
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: _isSubmitting ? null : () => Navigator.of(context).pop(),
                            child: const Text('Cancel'),
                          ),
                          const SizedBox(width: 12),
                          PrimaryButton(
                            onPressed: _isSubmitting ? () {} : () => _submit(communities),
                            label: _isSubmitting ? 'Uploading...' : 'Upload',
                            icon: Icons.cloud_upload_outlined,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            loading: () => const Center(
              child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(),
              ),
            ),
            error: (err, st) => Center(child: Text('Error: $err')),
          ),
        ),
      ),
    );
  }
}
