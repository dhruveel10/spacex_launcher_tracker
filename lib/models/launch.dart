class Launch {
  final String id;
  final String name;
  final DateTime dateUtc;
  final String rocket;
  final String launchpad;
  final String? imageUrl;
  final String missionDetails;
  final String? webcastLink;

  Launch({
    required this.id,
    required this.name,
    required this.dateUtc,
    required this.rocket,
    required this.launchpad,
    this.imageUrl,
    required this.missionDetails,
    this.webcastLink,
  });

  factory Launch.fromJson(Map<String, dynamic> json) {
    return Launch(
      id: json['id'],
      name: json['name'],
      dateUtc: DateTime.parse(json['date_utc']),
      rocket: json['rocket'],
      launchpad: json['launchpad'],
      imageUrl: json['links']?['patch']?['small'],
      missionDetails: json['details'] ?? 'No details available',
      webcastLink: json['links']?['webcast'],
    );
  }
}
