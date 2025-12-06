import 'dart:convert';

class StockLine {
  final String id;
  final String stockId;
  final String productId;
  final String productName;
  final int quantity;
  final String description;
  final double price;
  final double totalLine;
  final String syncRow;
  final DateTime createdAt = DateTime.now();
  final String createdBy;

  StockLine({
    required this.id,
    required this.stockId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.description,
    required this.price,
    required this.totalLine,
    required this.syncRow,
    required this.createdBy,
  });

  // Convert object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'stockId': stockId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'description': description,
      'price': price,
      'totalLine': totalLine,
      'syncRow': syncRow,
      'createdBy': createdBy,
    };
  }

  StockLine copyWith({
    String? id,
    String? stockId,
    String? productId,
    String? productName,
    int? quantity,
    String? description,
    double? price,
    double? totalLine,
    String? syncRow,
    String? createdBy,
  }) {
    return StockLine(
      id: id ?? this.id,
      stockId: stockId ?? this.stockId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      description: description ?? this.description,
      price: price ?? this.price,
      totalLine: totalLine ?? this.totalLine,
      syncRow: syncRow ?? this.syncRow,
      createdBy: createdBy ?? this.createdBy,
    );
  }


  // Create object from Map
  factory StockLine.fromMap(Map<String, dynamic> map) {
    return StockLine(
      id: map['id'],
      stockId: map['stockId'],
      productId: map['productId'],
      productName: map['productName'],
      quantity: map['quantity'],
      description: map['description'] ?? '',
      price: map['price'],
      totalLine: map['totalLine'],
      syncRow: map['syncRow'],
      createdBy: map['createdBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory StockLine.fromJson(String source) => StockLine.fromMap(json.decode(source));
}
