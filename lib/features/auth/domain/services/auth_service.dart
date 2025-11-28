import 'package:e_commerce_app/features/auth/domain/models/check_auth.dart';
import 'package:e_commerce_app/features/auth/domain/models/user_entity.dart';


abstract class AuthService {
  Future<UserEntity> login(String userName, String password);
  Future<UserEntity> refresh(String token);
  Future<CheckAuth> checkAuth(String token, String userName);
  Future<void> logout();
  Future<bool> isLoggedIn();
  Future<UserEntity?> getCurrentUser();
}