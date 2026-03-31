import 'package:prototype/domain/entities/user.dart';
import 'package:prototype/domain/repositories/auth_repository.dart';
import 'package:prototype/data/datasources/mock/mock_data.dart';

class MockAuthRepository implements AuthRepository {
  User? _currentUser;

  @override
  Future<User?> login(String apartment, String password) async {
    await Future.delayed(const Duration(milliseconds: 300));

    if (apartment == '4-B') {
      _currentUser = mockCurrentUser;
      return _currentUser;
    }
    return null;
  }

  @override
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String apartment,
    required String tower,
    required String password,
  }) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return true;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 200));
    _currentUser = null;
  }

  @override
  Future<User?> getCurrentUser() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _currentUser;
  }
}
