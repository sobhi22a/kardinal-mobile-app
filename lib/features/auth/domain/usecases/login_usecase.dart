import 'package:e_commerce_app/features/auth/domain/models/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/services/auth_service.dart';

class LoginUseCase {
  final AuthService repository;

  LoginUseCase(this.repository);

  Future<UserEntity> call({
    required String userName,
    required String password,
  }) async {
    // Add validation logic here if needed
    if (userName.isEmpty || password.isEmpty) {
      throw Exception('Email and password cannot be empty');
    }

    return await repository.login(userName, password);
  }

/*bool _isValidEmail(String userName) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(userName);
  }*/
}