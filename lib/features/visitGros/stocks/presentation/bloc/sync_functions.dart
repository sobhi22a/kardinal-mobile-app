import 'package:e_commerce_app/core/functions/generate-random-number.dart';
import 'package:e_commerce_app/features/visitGros/stocks/data/models/create_stock_line_model.dart';
import 'package:e_commerce_app/features/visitGros/stocks/data/models/create_stock_model.dart';
import 'package:e_commerce_app/features/visitGros/stocks/domain/services/stock_service.dart';
import 'package:e_commerce_app/repositories/stocks/stock_lines_repository.dart';
import 'package:e_commerce_app/repositories/stocks/stock_repository.dart';

Future<void> syncStocks() async {
  final stockRepository = StockRepository();
  var stocks = await stockRepository.getAllStocksNotSync();

  for (var stock in stocks) {
    var createStockModel = CreateStockModel(
      id: stock.id,
      documentno: generateRandomNumber().toString(),
      dateOrdered: stock.dateOrdered,
      clientId: stock.clientId,
      visitPlanId: stock.visitPlanId,
      grandTotal: stock.grandTotal,
      description: stock.description,
      createdBy: stock.createdBy,
      userId: stock.createdBy,
    );
    var create = await createStockService(createStockModel);
    if(create.Success == true) {
      await stockRepository.updateStock(stock.copyWith(syncRow: 'Y'));
    }
  }
}

Future<void> syncStockLine() async {
  final stockLineRepository = StockLineRepository();
  var stockLines = await stockLineRepository.getAllStockLinesNotSync();

  for (var stockLine in stockLines) {
    var createStockLineModel = CreateStockLineModel(
      id: stockLine.id,
      stockId: stockLine.stockId,
      productId: stockLine.productId,
      quantity: stockLine.quantity,
      price: stockLine.price,
      totalLine: stockLine.totalLine,
      description: stockLine.description,
      createdBy: stockLine.createdBy,
      userId: stockLine.createdBy,
    );
    var create = await createStockLineService(createStockLineModel);
    if(create.Success == true) {
      await stockLineRepository.updateStockLine(stockLine.copyWith(syncRow: 'Y'));
    }
  }
}