import 'package:e_commerce_app/database/models/command_line_model.dart';
import 'package:e_commerce_app/database/models/command_model.dart';

abstract class CommandsState {}

class CommandsStateInitialState extends CommandsState {}

class ListCliensState extends CommandsState {
  List<Map<String, dynamic>> list;
  ListCliensState(this.list);
}

class ListGrossitesState extends CommandsState {
  List<Map<String, dynamic>> list;
  ListGrossitesState(this.list);
}

class ListCommandsState extends CommandsState {
  List<Command> list;
  ListCommandsState(this.list);
}

class VisitPlanTodayState extends CommandsState {
  Map<String, dynamic> data;
  VisitPlanTodayState(this.data);
}

class CommandCreatingState extends CommandsState {
  CommandCreatingState();
}

class CommandLineCreatedSuccessState extends CommandsState{
  CommandLineCreatedSuccessState();
}
class CommandCreatedSuccessState extends CommandsState {
  final String commandId;
  final bool isSampleCommand;

  CommandCreatedSuccessState(this.commandId, this.isSampleCommand);
}


class ListProductsState extends CommandsState {
  List<Map<String, dynamic>> list;
  ListProductsState(this.list);
}

class ListCommandLinesByCommandState extends CommandsState {
  List<CommandLine> list;
  ListCommandLinesByCommandState(this.list);
}

// Command Detail Screen

class ListDetailProdctByCommandState extends CommandsState {
  List<CommandLine> list;
  ListDetailProdctByCommandState(this.list);
}

class TotalCommandState extends CommandsState {
  double commandTotalLine;
  double commandLineTotalLine;
  double grandTotal;
  double discount;
  TotalCommandState(this.commandTotalLine, this.commandLineTotalLine, this.grandTotal, this.discount);
}

class CommandDataLoadedState extends CommandsState {
  final List<Map<String, dynamic>> clients;
  final List<Map<String, dynamic>> grossiste;
  final Map<String, dynamic> visitPlanToday;
  final List<Command> commands;

  CommandDataLoadedState({
    required this.clients,
    required this.grossiste,
    required this.visitPlanToday,
    required this.commands,
  });
}

class CommandErrorState extends CommandsState {
  final String message;
  CommandErrorState(this.message);
}
