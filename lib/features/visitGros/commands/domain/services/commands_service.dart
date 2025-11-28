import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_response_model.dart';

abstract class CommandsService {
  Future<CreateCommandResponseModel> CreateCommandService (CreateCommandModel createCommandModel);
}