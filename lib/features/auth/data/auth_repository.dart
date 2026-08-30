import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../domain/user.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> signIn(String email, String password);
  Future<AppUser> register(String email, String password, String displayName);
  Future<void> signOut();
  Stream<AppUser?> authStateChanges();
}

class MockAuthRepository implements AuthRepository {
  AppUser? _currentUser;

  @override
  Stream<AppUser?> authStateChanges() async* {
    yield _currentUser;
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    return _currentUser;
  }

  @override
  Future<AppUser> register(String email, String password, String displayName) async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = AppUser(
      id: 'mock_id_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      displayName: displayName,
    );
    return _currentUser!;
  }

  @override
  Future<AppUser> signIn(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1));
    if (email == 'error@test.com') {
      throw Exception('Invalid credentials');
    }
    _currentUser = AppUser(
      id: 'mock_user_123',
      email: email,
      displayName: 'Kenji',
      photoUrl: 'https://i.pravatar.cc/150?u=kenji',
      reputation: 150,
      badges: ['early_adopter'],
    );
    return _currentUser!;
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
  }
}

@riverpod
AuthRepository authRepository(Ref ref) {
  // Return mock for now, will replace with Firebase later
  return MockAuthRepository();
}
