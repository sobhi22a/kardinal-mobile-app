import 'package:equatable/equatable.dart';

class CreateStockModel extends Equatable {
  final String id;
  final String documentno;
  final String dateOrdered;
  final String clientId;
  final String visitPlanId;
  final double grandTotal;
  final String description;
  final String createdBy;
  final String userId;

  const CreateStockModel({
    required this.id,
    required this.documentno,
    required this.dateOrdered,
    required this.clientId,
    required this.visitPlanId,
    required this.grandTotal,
    required this.description,
    required this.createdBy,
    required this.userId,
  });

  // Convert to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'documentno': documentno,
      'dateOrdered': dateOrdered,
      'clientId': clientId,
      'visitPlanId': visitPlanId,
      'grandTotal': grandTotal,
      'description': description,
      'createdBy': createdBy,
      'userId': userId,
    };
  }

  // Create from JSON (optional)
  factory CreateStockModel.fromJson(Map<String, dynamic> json) {
    return CreateStockModel(
      id: json['id'] as String,
      documentno: json['documentno'] as String,
      dateOrdered: json['dateOrdered'] as String,
      clientId: json['clientId'] as String,
      visitPlanId: json['visitPlanId'] as String,
      createdBy: json['createdBy'] as String,
      grandTotal: (json['grandTotal'] as num).toDouble(),
      description: json['description'] as String,
      userId: json['userId'] as String,
    );
  }

  @override
  List<Object?> get props => [
    documentno,
    dateOrdered,
    clientId,
    visitPlanId,
    grandTotal,
    description,
    createdBy,
    userId,
  ];
}