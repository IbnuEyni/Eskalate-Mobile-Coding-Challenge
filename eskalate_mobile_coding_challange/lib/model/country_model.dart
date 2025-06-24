class Country {
  final String name;
  final String flagImageUrl;
  final String population;
  final String area;
  final String region;
  final String subRegion;
  final List<String> timezones;

  Country({
    required this.name,
    required this.flagImageUrl,
    required this.population,
    required this.area,
    required this.region,
    required this.subRegion,
    required this.timezones,
  });

  factory Country.fromJson(Map<String, dynamic> json) {
    final String commonName =
        json['name'] != null ? json['name']['common'] ?? 'N/A' : 'N/A';
    String flagSource = '';
    if (json['flags'] != null && json['flags']['svg'] != null) {
      flagSource = json['flags']['svg'] as String;
    } else if (json['flag'] != null) {
      flagSource = json['flag'] as String;
    }

    return Country(
      name: commonName,
      flagImageUrl: flagSource,
      population:
          json['population'] != null ? json['population'].toString() : 'N/A',
      area: json['area'] != null ? '${json['area']} sq km' : 'N/A',
      region: json['region'] ?? 'N/A',
      subRegion: json['subregion'] ?? 'N/A',
      timezones:
          json['timezones'] != null ? List<String>.from(json['timezones']) : [],
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Country &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}
