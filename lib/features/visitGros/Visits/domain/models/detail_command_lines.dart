class DetailCommandLine {
  final String id;
  final String commandId;
  final String productId;
  final String productName;
  final int quantity;
  final int bonus;
  final int totalQuantity;
  final double price;
  final String description;
  final int totalLine;
  final String createdBy;
  final String? createdByName;
  final String? modifiedBy;
  final String? modifiedByName;
  final DateTime created;
  final DateTime? modified;

  DetailCommandLine({
    required this.id,
    required this.commandId,
    required this.productId,
    required this.productName,
    required this.quantity,
    required this.bonus,
    required this.totalQuantity,
    required this.price,
    required this.description,
    required this.totalLine,
    required this.createdBy,
    this.createdByName,
    this.modifiedBy,
    this.modifiedByName,
    required this.created,
    this.modified,
  });

  factory DetailCommandLine.fromJson(Map<String, dynamic> json) {
    DateTime parseDateNonDefault(String? s) {
      if (s == null) return DateTime.fromMillisecondsSinceEpoch(0);
      // treat "0001-01-01T00:00:00Z" (default .NET DateTime) as null/epoch sentinel
      if (s.startsWith('0001-01-01')) {
        return DateTime.fromMillisecondsSinceEpoch(0);
      }
      return DateTime.parse(s);
    }

    DateTime? parseNullableDate(String? s) {
      if (s == null) return null;
      if (s.startsWith('0001-01-01')) return null;
      return DateTime.parse(s);
    }

    return DetailCommandLine(
      id: json['id'] as String,
      commandId: json['commandId'] as String,
      productId: json['productId'] as String,
      productName: json['productName'] as String,
      quantity: (json['quantity'] as num).toInt(),
      bonus: (json['bonus'] as num).toInt(),
      totalQuantity: (json['totalQuantity'] as num).toInt(),
      price: (json['price'] as num).toDouble(),
      description: (json['description'] ?? '') as String,
      totalLine: (json['totalLine'] as num).toInt(),
      createdBy: json['createdBy'] as String,
      createdByName: json['createdByName'] as String?,
      modifiedBy: json['modifiedBy'] as String?,
      modifiedByName: json['modifiedByName'] as String?,
      created: parseDateNonDefault(json['created'] as String?),
      modified: parseNullableDate(json['modified'] as String?),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'commandId': commandId,
    'productId': productId,
    'productName': productName,
    'quantity': quantity,
    'bonus': bonus,
    'totalQuantity': totalQuantity,
    'price': price,
    'description': description,
    'totalLine': totalLine,
    'createdBy': createdBy,
    'createdByName': createdByName,
    'modifiedBy': modifiedBy,
    'modifiedByName': modifiedByName,
    'created': created.toUtc().toIso8601String(),
    'modified': modified?.toUtc().toIso8601String(),
  };

  /// convenience copyWith
  DetailCommandLine copyWith({
    String? id,
    String? commandId,
    String? productId,
    String? productName,
    int? quantity,
    int? bonus,
    int? totalQuantity,
    double? price,
    String? description,
    int? totalLine,
    String? createdBy,
    String? createdByName,
    String? modifiedBy,
    String? modifiedByName,
    DateTime? created,
    DateTime? modified,
  }) {
    return DetailCommandLine(
      id: id ?? this.id,
      commandId: commandId ?? this.commandId,
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      quantity: quantity ?? this.quantity,
      bonus: bonus ?? this.bonus,
      totalQuantity: totalQuantity ?? this.totalQuantity,
      price: price ?? this.price,
      description: description ?? this.description,
      totalLine: totalLine ?? this.totalLine,
      createdBy: createdBy ?? this.createdBy,
      createdByName: createdByName ?? this.createdByName,
      modifiedBy: modifiedBy ?? this.modifiedBy,
      modifiedByName: modifiedByName ?? this.modifiedByName,
      created: created ?? this.created,
      modified: modified ?? this.modified,
    );
  }
}

/// Wrapper for response with a list of command lines and a totalLines field.
class CommandLinesResponse {
  final List<DetailCommandLine> commandLines;
  final int totalLines;

  CommandLinesResponse({
    required this.commandLines,
    required this.totalLines,
  });

  factory CommandLinesResponse.fromJson(Map<String, dynamic> json) {
    final list = (json['commandLines'] as List<dynamic>?)
        ?.map((e) => DetailCommandLine.fromJson(e as Map<String, dynamic>))
        .toList() ??
        <DetailCommandLine>[];

    return CommandLinesResponse(
      commandLines: list,
      totalLines: (json['totalLines'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() => {
    'commandLines': commandLines.map((e) => e.toJson()).toList(),
    'totalLines': totalLines,
  };
}
