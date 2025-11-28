import 'dart:convert';

class Command {
  final String id;
  final String documentno;
  final String dateOrdered;
  final String clientId;
  final String clientName;
  final int status;
  final int type;
  final double totalLine;
  final double discount;
  final double grandTotal;
  final String visitPlanId;
  final double latitude;
  final double longitude;
  final List<String> suppliers;
  final String description;
  final String syncRow;
  final String createdBy;

  Command({
    required this.id,
    required this.documentno,
    required this.dateOrdered,
    required this.clientId,
    required this.clientName,
    required this.status,
    required this.type,
    required this.totalLine,
    required this.discount,
    required this.grandTotal,
    required this.visitPlanId,
    required this.latitude,
    required this.longitude,
    required this.suppliers,
    required this.description,
    required this.syncRow,
    required this.createdBy,
  });

  Command copyWith({
    String? id,
    String? documentno,
    String? dateOrdered,
    String? clientId,
    String? clientName,
    int? status,
    int? type,
    double? totalLine,
    double? discount,
    double? grandTotal,
    String? visitPlanId,
    double? latitude,
    double? longitude,
    List<String>? suppliers,
    String? description,
    String? syncRow,
    String? createdBy,
  }) {
    return Command(
      id: id ?? this.id,
      documentno: documentno ?? this.documentno,
      dateOrdered: dateOrdered ?? this.dateOrdered,
      clientId: clientId ?? this.clientId,
      clientName: clientName ?? this.clientName,
      status: status ?? this.status,
      type: type ?? this.type,
      totalLine: totalLine ?? this.totalLine,
      discount: discount ?? this.discount,
      grandTotal: grandTotal ?? this.grandTotal,
      visitPlanId: visitPlanId ?? this.visitPlanId,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      suppliers: suppliers ?? this.suppliers,
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
    'status': status,
    'type': type,
    'totalLine': totalLine,
    'discount': discount,
    'grandTotal': grandTotal,
    'visitPlanId': visitPlanId,
    'latitude': latitude,
    'longitude': longitude,
    'suppliers': jsonEncode(suppliers),
    'description': description,
    'syncRow': syncRow,
    'createdBy': createdBy,
  };

  factory Command.fromMap(Map<String, dynamic> map) => Command(
    id: map['id'],
    documentno: map['documentno'],
    dateOrdered: map['dateOrdered'],
    clientId: map['clientId'],
    clientName: map['clientName'],
    status: map['status'],
    type: map['type'],
    totalLine: map['totalLine'],
    discount: map['discount'],
    grandTotal: map['grandTotal'],
    visitPlanId: map['visitPlanId'],
    latitude: map['latitude'],
    longitude: map['longitude'],
    suppliers: List<String>.from(jsonDecode(map['suppliers'] ?? '[]')),
    description: map['description'],
    syncRow: map['syncRow'],
    createdBy: map['createdBy'],
  );
}
