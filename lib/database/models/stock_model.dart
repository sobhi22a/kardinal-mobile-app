import 'dart:convert';

class Stock {
  final String id;
  final String documentno;
  final String dateOrdered;
  final String clientId;
  final String clientName;
  final String visitPlanId;
  final String description;
  final double grandTotal;
  final String syncRow;
  final String createdBy;

  Stock({
    required this.id,
    required this.documentno,
    required this.dateOrdered,
    required this.clientId,
    required this.clientName,
    required this.visitPlanId,
    required this.description,
    required this.grandTotal,
    required this.syncRow,
    required this.createdBy,
  });

  Stock copyWith({
    String? id,
    String? documentno,
    String? dateOrdered,
    String? clientId,
    String? clientName,
    String? visitPlanId,
    String? description,
    double? grandTotal,
    String? syncRow,
    String? createdBy,
  }) {
    return Stock(
      id: id ?? this.id,
      documentno: documentno ?? this.documentno,
      dateOrdered: dateOrdered ?? this.dateOrdered,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      visitPlanId: visitPlanId ?? this.visitPlanId,
      grandTotal: grandTotal ?? this.grandTotal,
      syncRow: syncRow ?? this.syncRow,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'documentno': documentno,
    'dateOrdered': dateOrdered,
    'clientId': clientId,
    'clientName': clientName,
    'visitPlanId': visitPlanId,
    'grandTotal': grandTotal,
    'description': description,
    'syncRow': syncRow,
    'createdBy': createdBy,
  };

  factory Stock.fromMap(Map<String, dynamic> map) => Stock(
    id: map['id'],
    documentno: map['documentno'],
    dateOrdered: map['dateOrdered'],
    clientId: map['clientId'],
    clientName: map['clientName'],
    visitPlanId: map['visitPlanId'],
    description: map['description'],
    grandTotal: map['grandTotal'] ?? 0.0,
    syncRow: map['syncRow'],
    createdBy: map['createdBy'],
  );
}
