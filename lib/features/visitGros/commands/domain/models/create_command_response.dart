import 'package:equatable/equatable.dart';

class CreateCommandResponse extends Equatable {
  final String CommandId;
  final bool Success;

  const CreateCommandResponse({
    required this.CommandId,
    required this.Success,
  });

  @override
  List<Object?> get props => [CommandId, Success];
}