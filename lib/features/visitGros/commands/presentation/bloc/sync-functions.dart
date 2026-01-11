import 'package:e_commerce_app/core/functions/generate-random-number.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_line_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/domain/services/commands_service_impl.dart';
import 'package:e_commerce_app/repositories/commands/command_line_repository.dart';
import 'package:e_commerce_app/repositories/commands/command_repository.dart';

void syncCommands() async {
  final commandRepository = CommandRepository();
  var commands = await commandRepository.getAllCommandsNotSync();
  for (var command in commands) {
    var createCommandModel = CreateCommandModel(
      id: command.id,
      documentno: generateRandomNumber().toString(),
      dateOrdered: command.dateOrdered,
      clientId: command.clientId,
      status: command.status,
      type: command.type,
      totalLine: command.totalLine,
      discount: command.discount,
      grandTotal: command.grandTotal,
      visitPlanId: command.visitPlanId,
      latitude: command.latitude,
      longitude: command.longitude,
      description: command.description,
      createdBy: command.createdBy,
      suppliers: command.suppliers,
    );
    var create = await createCommandService(createCommandModel);
    if(create.Success == true) {
      await commandRepository.updateCommand(command.copyWith(syncRow: 'Y'));
    }
  }
  syncCommandLines();
}

void syncCommandLines() async {
  final commandLinesRepository = CommandLineRepository();
  var commandLines = await commandLinesRepository.getAllCommandLinesNotSync();
  for (var commandLine in commandLines) {
    var createCommandLineModel = new CreateCommandLineModel(
      id: commandLine.id,
      commandId: commandLine.commandId,
      productId: commandLine.productId,
      quantity: commandLine.quantity.toInt(),
      ug: commandLine.ug,
      totalQuantity: commandLine.totalQuantity.toInt(),
      price: commandLine.price,
      description: commandLine.description,
      totalLine: commandLine.totalLine,
      status: 2,
      createdBy: commandLine.createdBy,
    );
    var create = await createCommandLineService(createCommandLineModel);
    if(create.Success == true) {
      await commandLinesRepository.updateCommandLine(commandLine.copyWith(syncRow: 'Y'));
    }
  }

}