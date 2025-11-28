import 'package:e_commerce_app/core/network/dio_client_network.dart';
import 'package:e_commerce_app/features/visitGros/Visits/domain/models/detail_command_lines.dart';
import 'package:e_commerce_app/features/visitGros/Visits/domain/models/visit_response.dart';
import 'package:e_commerce_app/features/visitGros/commons/models/Tiers.dart';

Future<VisitResponse> getAllVisitPlanService({ required UserId, VisitDate }) async {
  try {
    final response = await DioClientNetwork.get('/VisitGros/get-all-visit-plan', queryParameters: {"UserId": UserId, "VisitDate": VisitDate, "PageNumber": 1, "PageSize": 100 });

    if (response.statusCode == 200) {
      final visitResponse = VisitResponse.fromJson(response.data);
      return visitResponse;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}

Future<List<dynamic>> getAllCommandByVisitIdService({ required userId, required visitId }) async {
  try {
    final response = await DioClientNetwork.get('/Command/get-all-commands-by-visitId', queryParameters: {"userId": userId, "visitId": visitId });

    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}

Future<CommandLinesResponse> getCommandLineByCommandIdService({ required commandId }) async {
  try {
    final response = await DioClientNetwork.get('/Command/get-command-lines-by-commandId', queryParameters: {"commandId": commandId, });

    if (response.statusCode == 200) {
      var data = CommandLinesResponse.fromJson(response.data);
      return data;
    } else {
      throw Exception('Failed to get tiers: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Failed to get tiers: $e');
  }
}

Future<List<Tier>> getAllClientByRegionIdAndGroupService({ required regionId, required groupTier }) async {
  try {
    final response = await DioClientNetwork.get('/Command/get-clients-by-region-and-group', queryParameters: {"regionId": regionId, "groupTier": groupTier});

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