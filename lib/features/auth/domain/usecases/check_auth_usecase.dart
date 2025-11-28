import 'package:e_commerce_app/features/auth/domain/services/auth_service.dart';

class CheckAuthUseCase {
  final AuthService repository;

  CheckAuthUseCase(this.repository);

  Future<bool> call() async {
    return await repository.isLoggedIn();
  }
}