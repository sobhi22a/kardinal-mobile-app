import 'package:e_commerce_app/features/auth/domain/services/auth_service.dart';

class LogoutUseCase {
  final AuthService repository;

  LogoutUseCase(this.repository);

  Future<void> call() async {
    return await repository.logout();
  }
}