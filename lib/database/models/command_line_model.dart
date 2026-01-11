import 'dart:convert';

class CommandLine {
  final String id; // Local ID (UUID)
  final String commandId;
  final String productId;
  final String productName;
  final int quantity;
  final double ug;
  final int totalQuantity;
  final double price;
  final String description;
  final double totalLine;
  final String syncRow;
  final String createdBy;

  CommandLine({
    required this.id,
    required this.commandId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.ug,
    required this.totalQuantity,
    required this.price,
    required this.description,
    required this.totalLine,
    required this.syncRow,
    required this.createdBy,
  });

  // Convert object to Map (for SQLite)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'commandId': commandId,
      'productId': productId,
      'productName': productName,
      'quantity': quantity,
      'ug': ug,
      'totalQuantity': totalQuantity,
      'price': price,
      'description': description,
      'totalLine': totalLine,
      'syncRow': syncRow,
      'createdBy': createdBy,
    };
  }

  CommandLine copyWith({
    String? id,
    String? commandId,
    String? productId,
    String? productName,
    int? quantity,
    double? ug,
    int? totalQuantity,
    double? price,
    String? description,
    double? totalLine,
    String? syncRow,
    String? createdBy,
  }) {
    return CommandLine(
      id: id ?? this.id,
      commandId: commandId ?? this.commandId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      ug: ug ?? this.ug,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      price: price ?? this.price,
      description: description ?? this.description,
      totalLine: totalLine ?? this.totalLine,
      syncRow: syncRow ?? this.syncRow,
      createdBy: createdBy ?? this.createdBy,
    );
  }


  // Create object from Map
  factory CommandLine.fromMap(Map<String, dynamic> map) {
    return CommandLine(
      id: map['id'],
      commandId: map['commandId'],
      productId: map['productId'],
      productName: map['productName'],
      quantity: map['quantity'],
      ug: map['ug'],
      totalQuantity: map['totalQuantity'],
      price: map['price'] is int ? (map['price'] as int).toDouble() : map['price'],
      description: map['description'] ?? '',
      totalLine: map['totalLine'] is int ? (map['totalLine'] as int).toDouble() : map['totalLine'],
      syncRow: map['syncRow'],
      createdBy: map['createdBy'],
    );
  }

  String toJson() => json.encode(toMap());

  factory CommandLine.fromJson(String source) =>
      CommandLine.fromMap(json.decode(source));
}
