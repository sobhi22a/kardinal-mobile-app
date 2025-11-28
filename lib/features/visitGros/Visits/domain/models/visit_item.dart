class VisitItem {
  final String id;
  final String regionId;
  final String regionName;
  final String visitorId;
  final String visitorName;
  final String responsibleId;
  final String responsibleName;
  final String visitDate; // your format: "15-11-2025"
  final int status;
  final String statusName;
  final String createdBy;
  final DateTime createdDate;
  final String? modifiedBy;
  final DateTime updatedDate;

  VisitItem({
    required this.id,
    required this.regionId,
    required this.regionName,
    required this.visitorId,
    required this.visitorName,
    required this.responsibleId,
    required this.responsibleName,
    required this.visitDate,
    required this.status,
    required this.statusName,
    required this.createdBy,
    required this.createdDate,
    required this.modifiedBy,
    required this.updatedDate,
  });

  factory VisitItem.fromJson(Map<String, dynamic> json) {
    return VisitItem(
      id: json['id'],
      regionId: json['regionId'],
      regionName: json['regionName'],
      visitorId: json['visitorId'],
      visitorName: json['visitorName'],
      responsibleId: json['responsibleId'],
      responsibleName: json['responsibleName'],
      visitDate: json['visitDate'],
      status: json['status'],
      statusName: json['statusName'],
      createdBy: json['createdBy'],
      createdDate: DateTime.parse(json['createdDate']),
      modifiedBy: json['modifiedBy'],
      updatedDate: DateTime.parse(json['updatedDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'regionId': regionId,
      'regionName': regionName,
      'visitorId': visitorId,
      'visitorName': visitorName,
      'responsibleId': responsibleId,
      'responsibleName': responsibleName,
      'visitDate': visitDate,
      'status': status,
      'statusName': statusName,
      'createdBy': createdBy,
      'createdDate': createdDate.toIso8601String(),
      'modifiedBy': modifiedBy,
      'updatedDate': updatedDate.toIso8601String(),
    };
  }
}
