import 'package:prototype/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User?> login(String apartment, String password);
  Future<bool> register({
    required String name,
    required String email,
    required String phone,
    required String apartment,
    required String tower,
    required String password,
  });
  Future<void> logout();
  Future<User?> getCurrentUser();
}
