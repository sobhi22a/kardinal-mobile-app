import 'package:e_commerce_app/core/functions/current_user.dart';
import 'package:e_commerce_app/core/functions/formatDate.dart';
import 'package:e_commerce_app/features/visitGros/Visits/domain/services/visit_service_impl.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VisitsBloc extends Cubit<VisitsState> {
  VisitsBloc() : super(VisitsStateInitialState());

  static VisitsBloc get(context) => BlocProvider.of(context);


  void GetAllVisitsForUser({ visitDate }) async {
    var user = await currentUser();
    if (user?.id == null) {
      return;
    }
    var inverseVisitDate = invertToMonthDayYear(visitDate);
    var response = await getAllVisitPlanService(UserId: user?.id, VisitDate: inverseVisitDate);
    emit(ListVisitsState(response));
  }

  void GetAllCommandByVisitId(visitId) async {
    var user = await currentUser();
    if (user?.id == null) {
      return;
    }
    var response = await getAllCommandByVisitIdService(userId: user?.id, visitId: visitId);
    emit(ListCommandByVisitState(response));
  }

  void GetCommandByCommandId(commandId) async {
    var response = await getCommandLineByCommandIdService(commandId: commandId);
    emit(ListCommandLineByCommandIdState(response));
  }

  void GetAllClientsByRegionIdAndGroup(regionId) async {
    var response = await getAllClientByRegionIdAndGroupService(regionId: regionId, groupTier: 1);
    emit(ListClientsByRegionIdAndGroupState(response));
  }
}
