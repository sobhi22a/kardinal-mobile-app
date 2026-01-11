import 'package:e_commerce_app/core/functions/current_user.dart';
import 'package:e_commerce_app/core/functions/formatDate.dart';
import 'package:e_commerce_app/features/visitGros/Visits/domain/services/visit_service_impl.dart';
import 'package:e_commerce_app/features/visitGros/Visits/presentation/ListVisits/bloc/visits_state.dart';
import 'package:e_commerce_app/features/visitGros/commands/domain/services/commands_service_impl.dart';
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
    print(response);
    emit(ListCommandByVisitState(response));
  }

  void GetCommandByCommandId(commandId) async {
    var response = await getCommandLineByCommandIdService(commandId: commandId);
    emit(ListCommandLineByCommandIdState(response));
  }

  void GetAllClientsByRegionIdAndGroup(visitPlanId) async {
    var response = await getClientsByVisitPlanService(visitPlanId: visitPlanId);
    emit(ListClientsByRegionIdAndGroupState(response));
  }

  void GetAllStockbyVisitId(visitId) async {
    var response = await getAllStockByVisitIdService(visitId: visitId);
    emit(ListStockByVisitIdState(response));
  }
}
