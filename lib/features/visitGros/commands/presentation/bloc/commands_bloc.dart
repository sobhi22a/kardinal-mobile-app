import 'package:e_commerce_app/core/functions/calculate-total-properties.dart';
import 'package:e_commerce_app/core/functions/convert_to_value_label.dart';
import 'package:e_commerce_app/core/functions/current_user.dart';
import 'package:e_commerce_app/core/functions/getTodayDate.dart';
import 'package:e_commerce_app/core/geoLocation/location_data.dart';
import 'package:e_commerce_app/core/router/app_router.dart';
import 'package:e_commerce_app/core/shared/Loading/easy_loading.dart';
import 'package:e_commerce_app/database/models/command_line_model.dart';
import 'package:e_commerce_app/database/models/command_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/domain/services/commands_service_impl.dart';
import 'package:e_commerce_app/features/visitGros/commands/presentation/bloc/commands_state.dart';
import 'package:e_commerce_app/repositories/commands/command_line_repository.dart';
import 'package:e_commerce_app/repositories/commands/command_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class CommandsBloc extends Cubit<CommandsState> {
  CommandsBloc() : super(CommandsStateInitialState());

  static CommandsBloc get(context) => BlocProvider.of(context);
  final _commandLineRepository = CommandLineRepository();
  final _commandRepository = CommandRepository();

  void createCommand({context, client, visitPlan, grossistes, simpleCreation, description}) async {

    var user = await currentUser();
    if (user?.id == null) {
      return;
    }

    var existClient = await _commandRepository.getCommandIsNewByClientId(clientId: client['value']);
    if (existClient != null) {
      return;
    }

    List<String> suppliers = grossistes.map((g) => g['value'].toString()).toList().cast<String>();

    var location = await getCurrentLocationAndAddress();
    if(location == null) {
      easyLoading('Erreur localisation', EasyLoadingEnum.error);
      return;
    }

    final id = const Uuid().v4();
    final createCommandModel = Command(
      id: id,
      documentno: 'CMD-${DateTime.now().millisecondsSinceEpoch}/${user!.id}',
      dateOrdered: DateTime.now().toIso8601String(),
      clientId: client['value'],
      clientName: client['label'],
      status: simpleCreation == true ? 2 : 1,
      type: simpleCreation == true ? 0 : 2,
      totalLine: 0,
      discount: 0,
      grandTotal: 0,
      visitPlanId: visitPlan['id'],
      latitude: location.latitude,
      longitude: location.longitude,
      suppliers: suppliers,
      description: description,
      syncRow: 'N',
      createdBy: user.id,
    );

    var create = await _commandRepository.insertCommand(createCommandModel);
    if(create == true) {
      emit(CommandCreatedSuccessState(id, simpleCreation));
    }
  }

  void validCommand(context, commandId) async {
    var command = await _commandRepository.getCommandById(commandId);
    if(command == null) {
      return;
    }
    var commandLine = await _commandLineRepository.getCommandLinesByCommandId(commandId);
    if(commandLine.isEmpty) {
      easyLoading('Aucune ligne valide dans la commande. Merci d’ajouter au moins un produit.', EasyLoadingEnum.error);
      return;
    }
    var updatedCommand = command.copyWith(status: 2);
    var update = await _commandRepository.updateCommand(updatedCommand);
    if (update == 1) {
      easyLoading('Vous avez validé la commande.', EasyLoadingEnum.success);
      GoRouter.of(context).push(AppRouter.home);
    }
  }

  Future<void> deleteAllCommands() async {
    var commands = await _commandRepository.getAllCommandsSync();
    for (var command in commands) {
      var response = await getOneCommandByCommandIdService(commandId: command.id);
      if(response.isNotEmpty) {
        await _commandRepository.deleteCommand(command.id);
      } else {
        await _commandRepository.updateCommand(command.copyWith(syncRow: 'N'));
      }
    }
  }

  Future<void> deleteAllCommandLines() async {
    var commandLines = await _commandLineRepository.getAllCommandLinesSync();
    for (var commandLine in commandLines) {
      var response = await getOneCommandLineByCommandLineIdService(commandLineId: commandLine.id);
      if(response.isNotEmpty) {
        await _commandLineRepository.deleteCommandLine(commandLine.id);
      } else {
        await _commandLineRepository.updateCommandLine(commandLine.copyWith(syncRow: 'N'));
      }
    }
  }

  Future<void> sumTotalLine(commandId) async {
    var response = await _commandLineRepository.getCommandLinesByCommandId(commandId);
    double totalLine = 0;
    for (var element in response) {
      totalLine += element.totalLine;
    }
    var command = await _commandRepository.getCommandById(commandId);
    if(command == null) {
      return;
    }
    var grandTotal = totalLine - (totalLine * (command.discount / 100));
    var updatedCommand = command.copyWith(totalLine: totalLine, grandTotal: grandTotal);
    var result = await _commandRepository.updateCommand(updatedCommand);
    if(result == 1) {
      getListOfCommands();
    }
  }

  void getListOfCommands() async {
    var response = await _commandRepository.getAllCommands();
    emit(ListCommandsState(response));
  }

  void getVisitByDate() async {
    var user = await currentUser();
    if (user?.id == null) {
      return;
    }

    var response = await getVisitByDateAndVisitorService(visitorId: user?.id, dayDate: getTodayDate());
    emit(VisitPlanTodayState(response));
    getClients(visitPlanId: response['id']);
  }

  void getClients({ visitPlanId }) async {
    final response = await getClientsByVisitPlanService(visitPlanId: visitPlanId);
    final converted = response.map((tier) => {'label': tier.fullName, 'value': tier.id}).toList();
    emit(ListCliensState(converted));
  }

  void getGrossiste() async {
    var response = await getTiersByGroupService(group: 2);
    var convert = convertToValueLabel(response, labelKey: 'fullName', valueKey: 'id');
    emit(ListGrossitesState(convert));
  }


  // part of Commands Line
  void getListProducts() async {
    var response = await getListProductsService();
    var convert = convertToValueLabel(response, labelKey: 'name', valueKey: 'id', extraKeys: ['price', 'ug']);
    emit(ListProductsState(convert));
  }


  void createCommandLine(commandLineData) async {

    var user = await currentUser();
    if (user?.id == null) {
      return;
    }

    var createCommandLine = CommandLine(
        id: const Uuid().v4(),
        commandId: commandLineData['commandId'],
        productId: commandLineData['productId'],
        productName: commandLineData['productName'],
        quantity: commandLineData['quantity'].toInt(),
        ug: commandLineData['ug'],
        totalQuantity: commandLineData['totalQuantity'].toInt(),
        price: commandLineData['price'],
        description: commandLineData['description'],
        totalLine: commandLineData['totalLine'],
        syncRow: 'N',
        createdBy: user!.id
    );
    var create = await _commandLineRepository.insertCommandLine(createCommandLine);
    if(create == true) {
      getListOfCommandLinesbyCommandId(commandLineData['commandId']);
      await sumTotalLine(commandLineData['commandId']);
      emit(CommandLineCreatedSuccessState());
    }
  }

  void getListOfCommandLinesbyCommandId(commandId) async {
     var response = await _commandLineRepository.getCommandLinesByCommandId(commandId);
     emit(ListCommandLinesByCommandState(response));
  }

  void removeLineCommand(String commandLineId, String commandId) async {
    var command = await _commandRepository.getCommandById(commandId);
    if(command != null && command.status == 1) {
      await _commandLineRepository.deleteCommandLine(commandLineId);
      await sumTotalLine(commandId);
      getListOfCommandLinesbyCommandId(commandId);
    }
      return; // command valider on peut suppriune ligne
  }

  // Command Detail Screen
  void listDetailProdctByCommand(commandId) async {
    var response = await _commandLineRepository.getCommandLinesByCommandId(commandId);
    emit(ListDetailProdctByCommandState(response));
  }

  void totalCommand(commandId) async {
    var command = await _commandRepository.getCommandById(commandId);
    if(command == null) {
      emit(TotalCommandState(0, 0 , 0, 0));
      return;
    }
    var response = await _commandLineRepository.getCommandLinesByCommandId(commandId);
    double commandLineTotalLine = calculateTotalProperties(response, (p) => p.totalLine);

    emit(TotalCommandState(command.totalLine, commandLineTotalLine, command.grandTotal, command.discount));
  }

}
