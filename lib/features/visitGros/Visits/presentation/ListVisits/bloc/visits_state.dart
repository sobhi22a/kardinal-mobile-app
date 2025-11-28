import 'package:e_commerce_app/features/visitGros/Visits/domain/models/detail_command_lines.dart';
import 'package:e_commerce_app/features/visitGros/Visits/domain/models/visit_response.dart';
import 'package:e_commerce_app/features/visitGros/commons/models/Tiers.dart';

abstract class VisitsState {}

class VisitsStateInitialState extends VisitsState {}

class ListVisitsState extends VisitsState {
  VisitResponse list;
  ListVisitsState(this.list);
}

class ListCommandByVisitState extends VisitsState {
  List<dynamic> list;
  ListCommandByVisitState(this.list);
}

class ListCommandLineByCommandIdState extends VisitsState {
  CommandLinesResponse list;
  ListCommandLineByCommandIdState(this.list);
}

class ListClientsByRegionIdAndGroupState extends VisitsState {
  List<Tier> list;
  ListClientsByRegionIdAndGroupState(this.list);
}
