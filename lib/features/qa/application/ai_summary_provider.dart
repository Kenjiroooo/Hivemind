import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ai_summary_provider.g.dart';

/// Returns a contextual AI summary for a question based on its ID and tags.
/// For MVP, this returns pre-written summaries mapped to question IDs.
/// The architecture is designed so the body of this provider can be
/// swapped with a real LLM API call (Gemini, OpenAI, etc.) in the future.
@riverpod
Future<String?> aiSummary(Ref ref, String questionId) async {
  // Simulate network/AI processing delay
  await Future.delayed(const Duration(milliseconds: 800));

  // Pre-written contextual summaries mapped to question IDs.
  // Future: replace with actual API call:
  //   final response = await geminiApi.generateContent(questionContext);
  //   return response.text;
  const summaries = {
    'q1': '''
**K-Map Simplification Summary**

The community consensus suggests the following approach:
- **Always prioritize larger groups**: Look for octets (8 cells) before quads (4) before pairs (2)
- **Groups eliminate variables**: An octet eliminates 3 variables, a quad eliminates 2, a pair eliminates 1
- **Overlapping is allowed**: Groups can share cells — use this to maximize group size
- **"Don't Care" conditions (X)**: Include them if they help form a larger group; ignore if not

*Key formula*: The number of variables in the final expression = (total variables) − (variables eliminated by grouping)
''',
    'q2': '''
**QuickSort Complexity Summary**

| Case | Complexity | When it happens |
|:--|:--|:--|
| Best | O(N log N) | Pivot always splits array in half |
| Average | O(N log N) | Random data distribution |
| **Worst** | **O(N²)** | Already sorted data + naive pivot |

**The Root Cause**: When the pivot is always the min or max element (e.g., first element on a sorted array), one partition has N-1 elements and the other has 0 — creating N recursive calls of decreasing size.

**Solutions**: Randomized pivot selection, "median of three", or use Merge Sort for guaranteed O(N log N).
''',
    'q3': '''
**Express Middleware Routing Summary**

The core issue is middleware scope. In Express.js:
- `app.use(middleware)` applies to **all routes**
- `router.use('/protected', middleware)` applies only to that path prefix

**Recommended pattern**:
```js
// Public routes (no auth needed)
app.use('/login', loginRouter);
app.use('/register', registerRouter);

// Apply auth middleware only for protected routes
app.use('/api', authMiddleware, apiRouter);
```
''',
  };

  return summaries[questionId];
}
