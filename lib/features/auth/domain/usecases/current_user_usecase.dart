import 'package:e_commerce_app/features/auth/domain/models/user_entity.dart';
import 'package:e_commerce_app/features/auth/domain/services/auth_service.dart';

class CurrentUserUsecase {
  final AuthService repository;

  CurrentUserUsecase(this.repository);

  Future<UserEntity?> call() async {
    return await repository.getCurrentUser();
  }
}