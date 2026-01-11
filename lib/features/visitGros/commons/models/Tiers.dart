class Tier {
  final String id;
  final String fullName;
  final String description;
  final DateTime? firstSale;
  final int groupTier;
  final int statusCreditTier;
  final String? rc;
  final String? ai;
  final String? nif;
  final String? nis;
  final String password;
  final String locationGps;
  final String location;
  final double? latitude;
  final double? longitude;
  final String urlGps;

  const Tier({
    required this.id,
    required this.fullName,
    required this.description,
    required this.firstSale,
    required this.groupTier,
    required this.statusCreditTier,
    required this.rc,
    required this.ai,
    required this.nif,
    required this.nis,
    required this.password,
    required this.locationGps,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.urlGps,
  });

  factory Tier.fromJson(Map<String, dynamic> json) {
    return Tier(
      id: json['id']?.toString() ?? '',
      fullName: json['fullName']?.toString() ?? '--',
      description: json['description']?.toString() ?? '--',

      firstSale: json['firstSale'] != null
          ? DateTime.tryParse(json['firstSale'].toString())
          : null,

      groupTier: (json['groupTier'] as num?)?.toInt() ?? 0,
      statusCreditTier: (json['statusCreditTier'] as num?)?.toInt() ?? 0,

      rc: json['rc'] as String?,
      ai: json['ai'] as String?,
      nif: json['nif'] as String?,
      nis: json['nis'] as String?,

      password: json['password']?.toString() ?? '--',
      locationGps: json['locationGps']?.toString() ?? '--',
      location: json['location']?.toString() ?? '--',

      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),

      urlGps: json['urlGps']?.toString() ?? '',
    );
  }
}
