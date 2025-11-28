import 'package:e_commerce_app/features/visitGros/commands/domain/models/create_command_response.dart';

class CreateCommandResponseModel extends CreateCommandResponse {
  CreateCommandResponseModel({
    required super.CommandId,
    required super.Success
  });

  factory CreateCommandResponseModel.fromJson(Map<String, dynamic> json) {
    return CreateCommandResponseModel(
      CommandId: json['CommandId'] ?? 0,
      Success: json['Success'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'CommandId': CommandId,
      'Success': Success,
    };
  }

  factory CreateCommandResponseModel.fromEntity(CreateCommandResponse entity) {
    return CreateCommandResponseModel(
      CommandId: entity.CommandId,
      Success: entity.Success,
    );
  }
}