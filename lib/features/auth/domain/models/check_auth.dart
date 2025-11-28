import 'package:equatable/equatable.dart';

class CheckAuth extends Equatable {
  final bool isAuthenticated;

  const CheckAuth({
    required this.isAuthenticated,
  });

  @override
  List<Object?> get props => [isAuthenticated];
}