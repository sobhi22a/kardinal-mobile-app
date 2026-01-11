import 'package:e_commerce_app/features/visitGros/commands/domain/models/create_command_line_request.dart';

class CreateCommandLineModel extends CreateCommandLineRequest {
  CreateCommandLineModel({
    required super.id,
    required super.commandId,
    required super.productId,
    required super.quantity,
    required super.ug,
    required super.totalQuantity,
    required super.price,
    required super.description,
    required super.totalLine,
    required super.status,
    required super.createdBy,
  });

  factory CreateCommandLineModel.fromJson(Map<String, dynamic> json) {
    return CreateCommandLineModel(
      id: json['id'] ?? 0,
      commandId: json['commandId'] ?? 0,
      productId: json['productId'] ?? 0,
      quantity: json['quantity'] ?? 0,
      ug: json['ug'] ?? 0,
      totalQuantity: json['totalQuantity'] ?? 0,
      price: json['price'] ?? 0,
      description: json['description'] ?? 0,
      totalLine: json['totalLine'] ?? 0,
      status: json['status'] ?? 0,
      createdBy: json['createdBy'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'commandId': commandId,
      'productId': productId,
      'quantity': quantity,
      'ug': ug,
      'totalQuantity': totalQuantity,
      'price': price,
      'description': description,
      'totalLine': totalLine,
      'status': status,
      'createdBy': createdBy,
    };
  }

  factory CreateCommandLineModel.fromEntity(CreateCommandLineRequest entity) {
    return CreateCommandLineModel(
      id: entity.id,
      commandId: entity.commandId,
      productId: entity.productId,
      quantity: entity.quantity,
      ug: entity.ug,
      totalQuantity: entity.totalQuantity,
      price: entity.price,
      description: entity.description,
      totalLine: entity.totalLine,
      status: entity.status,
      createdBy: entity.createdBy,
    );
  }
}