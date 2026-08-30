import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/buttons.dart';
import '../../../core/widgets/question_card.dart';
import '../../../core/widgets/resource_card.dart';
import '../data/community_repository.dart';
import '../../feed/data/feed_repository.dart';
import '../../resources/data/resource_repository.dart';

class CommunityScreen extends ConsumerStatefulWidget {
  final String communityId;

  const CommunityScreen({
    super.key,
    required this.communityId,
  });

  @override
  ConsumerState<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends ConsumerState<CommunityScreen> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    final communityFuture = ref.watch(communityRepositoryProvider).getCommunityDetails(widget.communityId);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Community'),
      ),
      body: FutureBuilder(
        future: communityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final community = snapshot.data;
          if (community == null) {
            return const Center(child: Text('Community not found.'));
          }

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  community.name,
                                  style: AppTypography.headlineLg,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${community.memberCount} Members • ${community.category}',
                                  style: AppTypography.bodySm.copyWith(color: AppColors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          ),
                          PrimaryButton(
                            onPressed: () {},
                            label: community.isJoined ? 'Joined' : 'Join',
                            icon: community.isJoined ? Icons.check : Icons.add,
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        community.description,
                        style: AppTypography.bodyMd,
                      ),
                      const SizedBox(height: 24),
                      // Custom Tab Bar
                      Row(
                        children: [
                          _buildTab(0, 'Discussions'),
                          const SizedBox(width: 16),
                          _buildTab(1, 'Resources'),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              _selectedTabIndex == 0 ? _buildDiscussionsSliver() : _buildResourcesSliver(),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedTabIndex == 0) {
            context.push('/ask');
          } else {
            // Upload resource
          }
        },
        child: Icon(_selectedTabIndex == 0 ? Icons.edit : Icons.upload),
      ),
    );
  }

  Widget _buildTab(int index, String label) {
    final isSelected = _selectedTabIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTabIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryContainer : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: isSelected ? null : Border.all(color: AppColors.outlineVariant),
        ),
        child: Text(
          label,
          style: AppTypography.labelMd.copyWith(
            color: isSelected ? AppColors.onPrimaryContainer : AppColors.onSurfaceVariant,
          ),
        ),
      ),
    );
  }

  Widget _buildDiscussionsSliver() {
    final feedFuture = ref.watch(feedRepositoryProvider).getHomeFeed(); // Mock
    return FutureBuilder(
      future: feedFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SliverToBoxAdapter(child: SizedBox());
        final questions = snapshot.data!;
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => QuestionCard(
                question: questions[index],
                onTap: () => context.push('/question/${questions[index].id}'),
              ),
              childCount: questions.length,
            ),
          ),
        );
      },
    );
  }

  Widget _buildResourcesSliver() {
    final resFuture = ref.watch(resourceRepositoryProvider).getResourcesByCommunity(widget.communityId);
    return FutureBuilder(
      future: resFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const SliverToBoxAdapter(child: SizedBox());
        final resources = snapshot.data!;
        if (resources.isEmpty) {
          return const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: Text('No resources available in this community yet.')),
            ),
          );
        }
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ResourceCard(
                resource: resources[index],
                onTap: () => context.push('/resource/${resources[index].id}'),
              ),
              childCount: resources.length,
            ),
          ),
        );
      },
    );
  }
}
