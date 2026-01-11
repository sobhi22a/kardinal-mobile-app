import 'package:equatable/equatable.dart';

class CreateCommandLineRequest extends Equatable {
  final String id;
  final String commandId;
  final String productId;
  final int quantity;
  final double ug;
  final int totalQuantity;
  final double price;
  final String description;
  final double totalLine;
  final int status;
  final String createdBy;

  const CreateCommandLineRequest({
    required this.id,
    required this.commandId,
    required this.productId,
    required this.quantity,
    required this.ug,
    required this.totalQuantity,
    required this.price,
    required this.description,
    required this.totalLine,
    required this.status,
    required this.createdBy,
  });

  // Convert to JSON for API request
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

  // Create from JSON (optional)
  factory CreateCommandLineRequest.fromJson(Map<String, dynamic> json) {
    return CreateCommandLineRequest(
      id: json['id'] as String,
      commandId: json['commandId'] as String,
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
      ug: json['ug'] as double,
      totalQuantity: json['totalQuantity'] as int,
      price: json['price'] as double,
      description: json['description'] as String,
      totalLine: json['totalLine'] as double,
      status: json['status'] as int,
      createdBy: json['createdBy'] as String,
    );
  }

  @override
  List<Object?> get props => [
    id,
    commandId,
    productId,
    quantity,
    description,
    totalLine,
    totalLine,
    status,
    createdBy,
  ];
}