import 'package:e_commerce_app/core/functions/convert_to_value_label.dart';
import 'package:e_commerce_app/core/functions/current_user.dart';
import 'package:e_commerce_app/core/functions/getTodayDate.dart';
import 'package:e_commerce_app/database/models/Stock_line_model.dart';
import 'package:e_commerce_app/database/models/stock_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/domain/services/commands_service_impl.dart';
import 'package:e_commerce_app/features/visitGros/stocks/presentation/bloc/stock_state.dart';
import 'package:e_commerce_app/repositories/stocks/stock_lines_repository.dart';
import 'package:e_commerce_app/repositories/stocks/stock_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

class StockBloc extends Cubit<StockState> {
  StockBloc() : super(StockStateInitialState());

  static StockBloc get(context) => BlocProvider.of(context);
  final _stockRepository = StockRepository();
  final _stockLineRepository = StockLineRepository();

  void getVisitByDate() async {
    var user = await currentUser();
    if (user?.id == null) {
      return;
    }

    var response = await getVisitByDateAndVisitorService(
      visitorId: user?.id,
      dayDate: getTodayDate(),
    );
    emit(VisitPlanTodayStockState(response));
    getClients(regionId: response['regionId']);
  }

  void getClients({regionId}) async {
    var response = await getTiersByRegionAndGroupService(
      group: 1,
      regionId: regionId,
    );
    final convert = convertToValueLabel(response, labelKey: 'fullName', valueKey: 'id');
    emit(ListCliensStockState(convert));
  }

  void createStock({client, visitPlanId, description}) async {
    var user = await currentUser();
    if (user?.id == null) {
      return;
    }
    final id = const Uuid().v4();
    final createStockModel = Stock(
      id: id,
      documentno: 'STK-${DateTime.now().millisecondsSinceEpoch}/${user!.id}',
      dateOrdered: DateTime.now().toIso8601String(),
      clientId: client['value'],
      clientName: client['label'],
      visitPlanId: visitPlanId,
      description: description.toString(),
      grandTotal: 0,
      syncRow: 'N',
      createdBy: user.id,
    );
    var create = await _stockRepository.insertStock(createStockModel);
    if(create == true) {
      emit(StockCreatedSuccessState(id, create));
    }
  }

  void getListOfStocks() async {
    var response = await _stockRepository.getAllStocks();
    emit(ListStocksState(response));
  }

  void getListProducts() async {
    var response = await getListProductsService();
    // var convert = convertToValueLabel(response, labelKey: 'name', valueKey: 'id', extraKeys: ['price', 'bonus']);
    emit(StockProductsLoadedStockState(response));
  }

  void getListOfStockLinesbyStockId(stockId) async {
    var response = await _stockLineRepository.getStockLinesByStockId(stockId);
    var stock = await _stockRepository.getStockById(stockId);

    emit(ListStockLinesByStockIdState(response, stock?.grandTotal ?? 0));
  }

  Future<void> createStockLine(dynamic data) async {
    final user = await currentUser();
    if (user?.id == null) return;

    final stockId = data['stockId'];
    if (stockId == null) return;

    final quantity = (data['quantity'] ?? 0).toInt();
    final price = (data['price'] ?? 0).toDouble();
    final totalLine = price * quantity;

    final stockLine = StockLine(
      id: const Uuid().v4(),
      stockId: stockId,
      productId: data['productId'],
      productName: data['productName'],
      quantity: quantity,
      price: price,
      totalLine: totalLine,
      description: '',
      syncRow: 'N',
      createdBy: user!.id,
    );

    final created = await _stockLineRepository.insertStockLine(stockLine);
    if (!created) return;

    // Refresh list
    getListOfStockLinesbyStockId(stockId);

    // Recalculate total for the stock
    final total = await _stockLineRepository.getStockLinesTotalByStockId(stockId);

    final stock = await _stockRepository.getStockById(stockId);
    if (stock == null) return;

    final updatedStock = stock.copyWith(grandTotal: total);
    await _stockRepository.updateStock(updatedStock);
  }
}