import 'package:e_commerce_app/features/visitGros/Visits/domain/models/visit_item.dart';

class VisitResponse {
  final List<VisitItem> items;
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final int totalPages;
  final bool hasPrevious;
  final bool hasNext;

  VisitResponse({
    required this.items,
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.totalPages,
    required this.hasPrevious,
    required this.hasNext,
  });

  factory VisitResponse.fromJson(Map<String, dynamic> json) {
    return VisitResponse(
      items: (json['items'] as List)
          .map((e) => VisitItem.fromJson(e))
          .toList(),
      pageNumber: json['pageNumber'],
      pageSize: json['pageSize'],
      totalCount: json['totalCount'],
      totalPages: json['totalPages'],
      hasPrevious: json['hasPrevious'],
      hasNext: json['hasNext'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'items': items.map((e) => e.toJson()).toList(),
      'pageNumber': pageNumber,
      'pageSize': pageSize,
      'totalCount': totalCount,
      'totalPages': totalPages,
      'hasPrevious': hasPrevious,
      'hasNext': hasNext,
    };
  }
}
