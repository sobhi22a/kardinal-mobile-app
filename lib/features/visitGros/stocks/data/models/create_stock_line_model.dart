import 'package:equatable/equatable.dart';

class CreateStockLineModel extends Equatable {
  final String id;
  final String stockId;
  final String productId;
  final int quantity;
  final String description;
  final double price;
  final double totalLine;
  final String createdBy;
  final String userId;

  const CreateStockLineModel({
    required this.id,
    required this.stockId,
    required this.productId,
    required this.quantity,
    required this.description,
    required this.price,
    required this.totalLine,
    required this.createdBy,
    required this.userId,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'stockId': stockId,
      'productId': productId,
      'quantity': quantity,
      'description': description,
      'price': price,
      'totalLine': totalLine,
      'createdBy': createdBy,
      'userId': userId,
    };
  }

  // Create from JSON (optional)
  factory CreateStockLineModel.fromJson(Map<String, dynamic> json) {
    return CreateStockLineModel(
      id: json['id'] as String,
      stockId: json['stockId'] as String,
      productId: json['productId'] as String,
      quantity: json['quantity'] as int,
      description: json['description'] as String,
      price: json['price'] as double,
      totalLine: (json['totalLine'] as num).toDouble(),
      createdBy: json['createdBy'] as String,
      userId: json['userId'] as String,
    );
  }

  @override
  List<Object?> get props => [
    id,
    stockId,
    productId,
    quantity,
    description,
    price,
    totalLine,
    createdBy,
    userId,
  ];
}