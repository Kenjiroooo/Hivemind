import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../features/auth/application/auth_service.dart';
import '../../features/auth/data/auth_repository.dart';

part 'token_provider.g.dart';

@riverpod
class TokenController extends _$TokenController {
  @override
  int build() {
    // We observe the current user's token balance.
    final user = ref.watch(authControllerProvider).valueOrNull;
    return user?.tokenBalance ?? 0;
  }

  Future<void> addTokens(int amount, {required String reason}) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    if (user == null) return;

    final newBalance = user.tokenBalance + amount;
    final newLifetime = user.lifetimeTokens + amount;

    // Update the user model locally
    final updatedUser = user.copyWith(
      tokenBalance: newBalance,
      lifetimeTokens: newLifetime,
    );

    // Save to repository
    await ref.read(authRepositoryProvider).updateUser(updatedUser);
    
    // In a real app we'd also log the transaction here.
    // Update local state directly so UI reacts immediately.
    state = newBalance;
  }

  Future<void> deductTokens(int amount, {required String reason}) async {
    final user = ref.read(authControllerProvider).valueOrNull;
    if (user == null) return;

    final newBalance = user.tokenBalance - amount;
    if (newBalance < 0) return; // Prevent negative tokens

    // Update the user model locally
    final updatedUser = user.copyWith(
      tokenBalance: newBalance,
    );

    // Save to repository
    await ref.read(authRepositoryProvider).updateUser(updatedUser);
    
    // Update local state directly so UI reacts immediately.
    state = newBalance;
  }
}
