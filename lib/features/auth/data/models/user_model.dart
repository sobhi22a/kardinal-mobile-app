import 'package:e_commerce_app/features/auth/domain/models/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.success,
    required super.firstName,
    required super.lastName,
    required super.refreshToken,
    required super.expiresIn,
    required super.errors,
    required super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'] ?? 0,
        success: json['success'] ?? 0,
        firstName: json['firstName'] ?? 0,
        lastName: json['lastName'] ?? 0,
        refreshToken: json['refreshToken'] ?? 0,
        expiresIn: json['expiresIn'] ?? 0,
        errors: json['errors'] ?? 0,
        token: json['token'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'success': success,
      'firstName': firstName,
      'lastName': lastName,
      'refreshToken': refreshToken,
      'expiresIn': expiresIn,
      'errors': errors,
      'token': token,
    };
  }

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      success: entity.success,
      firstName: entity.firstName,
      lastName: entity.lastName,
      refreshToken: entity.refreshToken,
      expiresIn: entity.expiresIn,
      errors: entity.errors,
      token: entity.token,
    );
  }

  void operator [](String other) {}
}