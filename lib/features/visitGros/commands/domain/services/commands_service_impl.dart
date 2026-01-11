import 'package:e_commerce_app/core/network/dio_client_network.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_line_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_line_response.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_model.dart';
import 'package:e_commerce_app/features/visitGros/commands/data/models/create_command_response_model.dart';
import 'package:e_commerce_app/features/visitGros/commons/models/Tiers.dart';

String command = '/Command';

Future<CreateCommandResponseModel> createCommandService(CreateCommandModel createCommandModel) async {
  try {
    final response = await DioClientNetwork.post('$command/create-command', data: createCommandModel.toJson());

    final createCommandResponseModel = CreateCommandResponseModel(
      CommandId: response.data['commandId'] ?? '',
      Success: response.data['success'] ?? false,
    );

    return createCommandResponseModel;
  } catch (e) {
    throw Exception('Failed to create command: $e');
  }
}

Future<Map> getOneCommandByCommandIdService({ required commandId }) async {
  try {
    final response = await DioClientNetwork.get('$command/get-one-command',
      queryParameters: { "id": commandId },
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


Future<dynamic> getTiersByRegionAndGroupService({
  required group,
  required regionId,
}) async {
  try {
    final response = await DioClientNetwork.get('$command/get-clients-by-region-and-group',
      queryParameters: { "groupTier": group, "regionId": regionId },
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


Future<List<Tier>> getClientsByVisitPlanService({ required visitPlanId }) async {
  try {
    final response = await DioClientNetwork.get('$command/get-clients-by-visit-plan', queryParameters: { "visitPlanId": visitPlanId });

    if (response.statusCode == 200) {
      final List<dynamic> dataList = response.data;
      final tiers = dataList.map((json) => Tier.fromJson(json)).toList();
      return tiers;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}


Future<dynamic> getTiersByGroupService({
  required group,
}) async {
  try {
    final response = await DioClientNetwork.get('$command/get-clients-by-group', queryParameters: {"group": group});

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}

Future<dynamic> getVisitByDateAndVisitorService({
  required visitorId,
  required dayDate,
}) async {
  try {
    final response = await DioClientNetwork.get('/VisitGros/get-by-day-and-visitor', queryParameters: {"visitorId": visitorId, "dateDay": dayDate});

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}

Future<dynamic> getListProductsService() async {
  try {
    final response = await DioClientNetwork.get('/ManagementProduct/get-all-products');

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}


Future<CreateCommandLineResponse> createCommandLineService(CreateCommandLineModel createCommandLineModel) async {
  try {
    final response = await DioClientNetwork.post(
      '$command/create-command-line',
      data: createCommandLineModel.toJson(),
    );

    final createCommandLineResponse = CreateCommandLineResponse(
      Message: response.data['message'] ?? '',
      Success: response.data['success'] ?? false,
    );

    return createCommandLineResponse;
  } catch (e) {
    throw Exception('Failed to create command: $e');
  }
}

Future<Map> getOneCommandLineByCommandLineIdService({ required commandLineId }) async {
  try {
    final response = await DioClientNetwork.get('$command/get-one-command-line-by-Id', queryParameters: {"id": commandLineId});
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to create command: $e');
  }
}