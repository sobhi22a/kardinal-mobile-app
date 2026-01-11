import 'package:e_commerce_app/core/network/dio_client_network.dart';
import 'package:e_commerce_app/features/visitGros/stocks/data/models/create_stock_line_model.dart';
import 'package:e_commerce_app/features/visitGros/stocks/data/models/create_stock_line_response.dart';
import 'package:e_commerce_app/features/visitGros/stocks/data/models/create_stock_model.dart';
import 'package:e_commerce_app/features/visitGros/stocks/data/models/create_stock_response.dart';

Future<CreateStockResponse> createStockService(CreateStockModel createStockModel) async {
  try {
    final response = await DioClientNetwork.post('/Stock/create-stock', data: createStockModel.toJson());

    final createStockResponseModel = CreateStockResponse(
      StockId: response.data['stockId'] ?? '',
      Success: response.data['success'] ?? false,
    );

    return createStockResponseModel;
  } catch (e) {
    throw Exception('Failed to create command: $e');
  }
}

Future<CreateStockLineResponse> createStockLineService(CreateStockLineModel createStockLineModel) async {
  try {
    final response = await DioClientNetwork.post('/Stock/create-stock-line', data: createStockLineModel.toJson());

    final createStockLineResponseModel = CreateStockLineResponse(
      StockLineId: response.data['stockLineId'] ?? '',
      Success: response.data['success'] ?? false,
    );

    return createStockLineResponseModel;
  } catch (e) {
    throw Exception('Failed to create command: $e');
  }
}

Future<Map> getOneStockByIdService({ required stockId }) async {
  try {
    final response = await DioClientNetwork.get('/Stock/get-stock-by-id',
      queryParameters: { "stockId": stockId },
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}

Future<Map> getOneStockLineByIdService({ required stockLineId }) async {
  try {
    final response = await DioClientNetwork.get('/Stock/get-stock-line-by-id', queryParameters: { "stockLineId": stockLineId });

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}