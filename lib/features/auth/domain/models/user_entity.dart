import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String id;
  final bool success;
  final String firstName;
  final String lastName;
  final String token;
  final String refreshToken;
  final int expiresIn;
  final dynamic errors;

  const UserEntity({
    required this.id,
    required this.success,
    required this.firstName,
    required this.lastName,
    required this.token,
    required this.refreshToken,
    required this.expiresIn,
    required this.errors,
  });

  @override
  List<Object?> get props => [id, success, firstName, lastName, token, refreshToken, expiresIn, errors];
}