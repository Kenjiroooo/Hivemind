import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vote_provider.g.dart';

/// Direction of a vote — either up, down, or none (no vote).
enum VoteDirection { up, down, none }

/// Holds the current vote state for all entities (questions + answers) keyed by their ID.
/// Also tracks per-entity score deltas so the UI can show adjusted scores without
/// needing a full data refetch.
class VoteState {
  /// Map of entityId → VoteDirection
  final Map<String, VoteDirection> votes;

  /// Map of entityId → score delta from the original (can be -1, 0, or +1)
  final Map<String, int> deltas;

  const VoteState({
    this.votes = const {},
    this.deltas = const {},
  });

  VoteState copyWith({
    Map<String, VoteDirection>? votes,
    Map<String, int>? deltas,
  }) {
    return VoteState(
      votes: votes ?? this.votes,
      deltas: deltas ?? this.deltas,
    );
  }

  VoteDirection directionFor(String id) => votes[id] ?? VoteDirection.none;
  int deltaFor(String id) => deltas[id] ?? 0;
  int adjustedScore(String id, int originalScore) => originalScore + deltaFor(id);
}

@Riverpod(keepAlive: true)
class VoteNotifier extends _$VoteNotifier {
  @override
  VoteState build() => const VoteState();

  /// Toggle upvote for the given entity.
  /// - If not voted → sets to UP (+1 delta)
  /// - If already UP → removes vote (0 delta)
  /// - If voted DOWN → switches to UP (+2 delta from -1 to +1)
  void toggleUpvote(String id) {
    final currentDirection = state.directionFor(id);
    final currentDelta = state.deltaFor(id);

    final Map<String, VoteDirection> newVotes = Map.from(state.votes);
    final Map<String, int> newDeltas = Map.from(state.deltas);

    if (currentDirection == VoteDirection.up) {
      // Cancel upvote
      newVotes[id] = VoteDirection.none;
      newDeltas[id] = currentDelta - 1;
    } else if (currentDirection == VoteDirection.down) {
      // Switch from down to up
      newVotes[id] = VoteDirection.up;
      newDeltas[id] = currentDelta + 2;
    } else {
      // New upvote
      newVotes[id] = VoteDirection.up;
      newDeltas[id] = currentDelta + 1;
    }

    state = state.copyWith(votes: newVotes, deltas: newDeltas);
  }

  /// Toggle downvote for the given entity.
  /// - If not voted → sets to DOWN (-1 delta)
  /// - If already DOWN → removes vote (0 delta)
  /// - If voted UP → switches to DOWN (-2 delta from +1 to -1)
  void toggleDownvote(String id) {
    final currentDirection = state.directionFor(id);
    final currentDelta = state.deltaFor(id);

    final Map<String, VoteDirection> newVotes = Map.from(state.votes);
    final Map<String, int> newDeltas = Map.from(state.deltas);

    if (currentDirection == VoteDirection.down) {
      // Cancel downvote
      newVotes[id] = VoteDirection.none;
      newDeltas[id] = currentDelta + 1;
    } else if (currentDirection == VoteDirection.up) {
      // Switch from up to down
      newVotes[id] = VoteDirection.down;
      newDeltas[id] = currentDelta - 2;
    } else {
      // New downvote
      newVotes[id] = VoteDirection.down;
      newDeltas[id] = currentDelta - 1;
    }

    state = state.copyWith(votes: newVotes, deltas: newDeltas);
  }

  /// Returns the adjusted score for an entity given its original score from the data source.
  int adjustedScore(String id, int originalScore) {
    return originalScore + state.deltaFor(id);
  }
}
