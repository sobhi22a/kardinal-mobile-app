import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_response_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/domain/services/commands_service.dart';

class CreateCommandUsecase {
  final CommandsService repository;

  CreateCommandUsecase(this.repository);

  Future<CreateCommandResponseModel> call(CreateCommandModel request) async {
    return await repository.CreateCommandService(request);
  }
}