class Tier {
  final String id;
  final String fullName;
  final String description;
  final DateTime firstSale;
  final int groupTier;
  final int statusCreditTier;
  final String rc;
  final String ai;
  final String nif;
  final String nis;
  final String password;
  final String locationGps;
  final String location;
  final double latitude;
  final double longitude;
  final String urlGps;

  Tier({
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
      id: json['id'],
      fullName: json['fullName'],
      description: json['description'],
      firstSale: DateTime.parse(json['firstSale']),
      groupTier: json['groupTier'],
      statusCreditTier: json['statusCreditTier'],
      rc: json['rc'],
      ai: json['ai'],
      nif: json['nif'],
      nis: json['nis'],
      password: json['password'],
      locationGps: json['locationGps'],
      location: json['location'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      urlGps: json['urlGps'],
    );
  }
}
