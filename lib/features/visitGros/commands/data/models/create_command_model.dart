import 'package:e_commerce_app/features/visitGros/commands/domain/models/create_command_request.dart';

class CreateCommandModel extends CreateCommandRequest {
  CreateCommandModel({
    required super.id,
    required super.documentno,
    required super.dateOrdered,
    required super.clientId,
    required super.status,
    required super.type,
    required super.totalLine,
    required super.discount,
    required super.grandTotal,
    required super.visitPlanId,
    required super.latitude,
    required super.longitude,
    required super.suppliers,
    required super.description,
    required super.createdBy});

  factory CreateCommandModel.fromJson(Map<String, dynamic> json) {
    return CreateCommandModel(
      id: json['id'] ?? '',
      documentno: json['documentno'] ?? 0,
      dateOrdered: json['dateOrdered'] ?? 0,
      clientId: json['clientId'] ?? 0,
      status: json['status'] ?? 0,
      type: json['type'] ?? 0,
      totalLine: json['totalLine'] ?? 0,
      discount: json['discount'] ?? 0,
      grandTotal: json['grandTotal'] ?? 0,
      visitPlanId: json['visitPlanId'] ?? 0,
      latitude: json['latitude'] ?? 0,
      longitude: json['longitude'] ?? 0,
      description: json['description'] ?? '',
      createdBy: json['createdBy'] ?? 0,
      suppliers: json['suppliers'] ?? [],
    );
  }

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
      'createdBy': createdBy,
      'suppliers': suppliers,
    };
  }

  factory CreateCommandModel.fromEntity(CreateCommandRequest entity) {
    return CreateCommandModel(
      id: entity.id,
      documentno: entity.documentno,
      dateOrdered: entity.dateOrdered,
      clientId: entity.clientId,
      status: entity.status,
      type: entity.type,
      totalLine: entity.totalLine,
      discount: entity.discount,
      grandTotal: entity.grandTotal,
      visitPlanId: entity.visitPlanId,
      latitude: entity.latitude,
      longitude: entity.longitude,
      description: entity.description,
      suppliers: entity.suppliers,
      createdBy: entity.createdBy,
    );
  }
}