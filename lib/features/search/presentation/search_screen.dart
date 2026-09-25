import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/premium_background.dart';
import '../../../core/widgets/question_card.dart';
import '../../../core/widgets/resource_card.dart';
import '../data/search_repository.dart';

class SearchScreen extends ConsumerStatefulWidget {
  final String? initialQuery;

  const SearchScreen({super.key, this.initialQuery});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  late final TextEditingController _controller;
  String _currentQuery = '';
  int _selectedFilter = 0; // 0 = All, 1 = Questions, 2 = Resources

  @override
  void initState() {
    super.initState();
    _currentQuery = widget.initialQuery ?? '';
    _controller = TextEditingController(text: _currentQuery);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchAsync = _currentQuery.trim().isEmpty
        ? null
        : ref.watch(searchResultsProvider(_currentQuery.trim()));

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: TextField(
          controller: _controller,
          autofocus: widget.initialQuery == null,
          onChanged: (val) => setState(() => _currentQuery = val),
          decoration: InputDecoration(
            hintText: 'Search questions, tags, notes...',
            border: InputBorder.none,
            suffixIcon: _currentQuery.isNotEmpty
                ? IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      _controller.clear();
                      setState(() => _currentQuery = '');
                    },
                  )
                : null,
          ),
          style: AppTypography.bodyLg,
        ),
      ),
      body: PremiumBackground(
        child: Column(
          children: [
            // Filter chips
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  _buildFilterChip(0, 'All'),
                  const SizedBox(width: 8),
                  _buildFilterChip(1, 'Questions'),
                  const SizedBox(width: 8),
                  _buildFilterChip(2, 'Resources'),
                ],
              ),
            ),
            const Divider(height: 1),

            // Results body
            Expanded(
              child: _currentQuery.trim().isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.search, size: 64, color: AppColors.onSurfaceVariant.withValues(alpha: 0.3)),
                          const SizedBox(height: 16),
                          Text('Search Hivemind', style: AppTypography.headlineSm),
                          const SizedBox(height: 8),
                          Text(
                            'Find questions, exam solutions, and peer notes.',
                            style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                          ),
                        ],
                      ),
                    )
                  : searchAsync!.when(
                      data: (results) {
                        if (results.isEmpty) {
                          return Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.search_off, size: 64, color: AppColors.onSurfaceVariant.withValues(alpha: 0.3)),
                                const SizedBox(height: 16),
                                Text('No results for "$_currentQuery"', style: AppTypography.headlineSm),
                                const SizedBox(height: 8),
                                Text(
                                  'Try checking your spelling or using more general terms.',
                                  style: AppTypography.bodyMd.copyWith(color: AppColors.onSurfaceVariant),
                                ),
                              ],
                            ),
                          );
                        }

                        final showQuestions = _selectedFilter == 0 || _selectedFilter == 1;
                        final showResources = _selectedFilter == 0 || _selectedFilter == 2;

                        return ListView(
                          padding: const EdgeInsets.all(16.0),
                          children: [
                            if (showQuestions && results.questions.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  'Questions (${results.questions.length})',
                                  style: AppTypography.labelMd.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              ...results.questions.map((q) => QuestionCard(
                                    question: q,
                                    onTap: () => context.push('/question/${q.id}'),
                                  )),
                              const SizedBox(height: 16),
                            ],
                            if (showResources && results.resources.isNotEmpty) ...[
                              Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: Text(
                                  'Resources (${results.resources.length})',
                                  style: AppTypography.labelMd.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.onSurfaceVariant,
                                  ),
                                ),
                              ),
                              ...results.resources.map((r) => ResourceCard(
                                    resource: r,
                                    onTap: () => context.push('/resource/${r.id}'),
                                  )),
                            ],
                          ],
                        );
                      },
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (err, st) => Center(child: Text('Search error: $err')),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(int index, String label) {
    final isSelected = _selectedFilter == index;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => setState(() => _selectedFilter = index),
      selectedColor: AppColors.primaryContainer,
      labelStyle: TextStyle(
        color: isSelected ? AppColors.onPrimaryContainer : AppColors.onSurface,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
