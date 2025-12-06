import 'package:e_commerce_app/database/models/Stock_line_model.dart';
import 'package:e_commerce_app/database/models/stock_model.dart';

abstract class StockState {}

class StockStateInitialState extends StockState {}

class VisitPlanTodayStockState extends StockState {
  Map<String, dynamic> data;
  VisitPlanTodayStockState(this.data);
}

class ListCliensStockState extends StockState {
  List<Map<String, dynamic>> list;
  ListCliensStockState(this.list);
}

class StockCreatedSuccessState extends StockState {
  String id;
  bool isCreated = true;
  StockCreatedSuccessState(this.id, this.isCreated);
}

class ListStocksState extends StockState {
  List<Stock> list;
  ListStocksState(this.list);
}

class StockProductsLoadedStockState extends StockState {
  List<dynamic> products;
  StockProductsLoadedStockState(this.products);
}

class ListStockLinesByStockIdState extends StockState {
  List<StockLine> list;
  double grandTotal;
  ListStockLinesByStockIdState(this.list, this.grandTotal);
}

