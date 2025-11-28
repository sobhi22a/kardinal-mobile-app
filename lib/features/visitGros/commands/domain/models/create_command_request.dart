import 'package:equatable/equatable.dart';

class CreateCommandRequest extends Equatable {
  final String id;
  final String documentno;
  final String dateOrdered;
  final String clientId;
  final int status;
  final int type;
  final double totalLine;
  final double discount;
  final double grandTotal;
  final String visitPlanId;
  final double latitude;
  final double longitude;
  final String description;
  final List<String> suppliers;
  final String createdBy;

  const CreateCommandRequest({
    required this.id,
    required this.documentno,
    required this.dateOrdered,
    required this.clientId,
    required this.status,
    required this.type,
    required this.totalLine,
    required this.discount,
    required this.grandTotal,
    required this.visitPlanId,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.suppliers,
    required this.createdBy,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentno': documentno,
      'dateOrdered': dateOrdered,
      'clientId': clientId,
      'status': status,
      'type': type,
      'totalLine': totalLine,
      'discount': discount,
      'grandTotal': grandTotal,
      'visitPlanId': visitPlanId,
      'latitude': latitude,
      'longitude': longitude,
      'description': description,
      'suppliers': suppliers,
      'createdBy': createdBy,
    };
  }

  // Create from JSON (optional)
  factory CreateCommandRequest.fromJson(Map<String, dynamic> json) {
    return CreateCommandRequest(
      id: json['id'] as String,
      documentno: json['documentno'] as String,
      dateOrdered: json['dateOrdered'] as String,
      clientId: json['clientId'] as String,
      status: json['status'] as int,
      type: json['type'] as int,
      totalLine: (json['totalLine'] as num).toDouble(),
      discount: (json['discount'] as num).toDouble(),
      grandTotal: (json['grandTotal'] as num).toDouble(),
      visitPlanId: json['visitPlanId'] as String,
      createdBy: json['createdBy'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      description: json['description'] as String,
      suppliers: (json['suppliers'] as List<dynamic>).cast<String>(),
    );
  }

  @override
  List<Object?> get props => [
    documentno,
    dateOrdered,
    clientId,
    status,
    type,
    totalLine,
    discount,
    grandTotal,
    visitPlanId,
    latitude,
    longitude,
    description,
    createdBy,
    suppliers,
  ];
}