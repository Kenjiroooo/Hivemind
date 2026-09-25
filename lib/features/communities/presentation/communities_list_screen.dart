import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/premium_background.dart';
import '../../../core/widgets/tag_chip.dart';
import '../data/community_repository.dart';
import '../domain/community.dart';

class CommunitiesListScreen extends ConsumerStatefulWidget {
  const CommunitiesListScreen({super.key});

  @override
  ConsumerState<CommunitiesListScreen> createState() => _CommunitiesListScreenState();
}

class _CommunitiesListScreenState extends ConsumerState<CommunitiesListScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final communitiesAsync = ref.watch(allCommunitiesProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Communities'),
      ),
      body: PremiumBackground(
        child: communitiesAsync.when(
          data: (communities) {
            final categories = ['All', ...{for (var c in communities) c.category}];

            final filtered = communities.where((c) {
              final matchesQuery = _searchQuery.isEmpty ||
                  c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                  c.description.toLowerCase().contains(_searchQuery.toLowerCase());
              final matchesCategory = _selectedCategory == 'All' || c.category == _selectedCategory;
              return matchesQuery && matchesCategory;
            }).toList();

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Discover Spaces', style: AppTypography.headlineLg),
                        const SizedBox(height: 8),
                        Text(
                          'Join study groups, departments, and topic channels.',
                          style: AppTypography.bodyLg.copyWith(color: AppColors.onSurfaceVariant),
                        ),
                        const SizedBox(height: 16),

                        // Search Bar
                        TextField(
                          onChanged: (val) => setState(() => _searchQuery = val),
                          decoration: InputDecoration(
                            hintText: 'Search communities...',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: AppColors.surfaceContainerHigh.withValues(alpha: 0.5),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Categories
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: categories.map((cat) {
                              final isSelected = cat == _selectedCategory;
                              return Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: ChoiceChip(
                                  label: Text(cat),
                                  selected: isSelected,
                                  onSelected: (_) => setState(() => _selectedCategory = cat),
                                  selectedColor: AppColors.primaryContainer,
                                  labelStyle: TextStyle(
                                    color: isSelected ? AppColors.onPrimaryContainer : AppColors.onSurface,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (filtered.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(48.0),
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.search_off, size: 48, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                            const SizedBox(height: 12),
                            Text('No communities found', style: AppTypography.headlineSm),
                          ],
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final community = filtered[index];
                          return _CommunityCard(community: community);
                        },
                        childCount: filtered.length,
                      ),
                    ),
                  ),
              ],
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, st) => Center(child: Text('Error loading communities: $err')),
        ),
      ),
    );
  }
}

class _CommunityCard extends ConsumerWidget {
  final Community community;

  const _CommunityCard({required this.community});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: InkWell(
        onTap: () => context.push('/community/${community.id}'),
        borderRadius: BorderRadius.circular(16),
        child: GlassCard(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.primaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        community.name.isNotEmpty ? community.name[0] : 'C',
                        style: AppTypography.headlineSm.copyWith(
                          color: AppColors.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          community.name,
                          style: AppTypography.headlineSm.copyWith(fontSize: 18),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            TagChip(label: community.category),
                            const SizedBox(width: 8),
                            Text(
                              '${community.memberCount} members',
                              style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () async {
                      await ref.read(communityRepositoryProvider).toggleJoinCommunity(community.id);
                      ref.invalidate(allCommunitiesProvider);
                      ref.invalidate(myCommunitiesProvider);
                      ref.invalidate(communityDetailProvider(community.id));
                    },
                    icon: Icon(
                      community.isJoined ? Icons.check : Icons.add,
                      size: 16,
                      color: community.isJoined ? AppColors.success : AppColors.primary,
                    ),
                    label: Text(
                      community.isJoined ? 'Joined' : 'Join',
                      style: TextStyle(
                        color: community.isJoined ? AppColors.success : AppColors.primary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(
                        color: community.isJoined ? AppColors.success : AppColors.primary,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                community.description,
                style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    ).animate().fadeIn(duration: 300.ms).slideY(begin: 0.05, end: 0);
  }
}
