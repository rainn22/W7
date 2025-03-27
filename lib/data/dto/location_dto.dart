class LocationDto {
  final String name;
  final String country;

  LocationDto({required this.name, required this.country});

  static LocationDto fromJson(Map<String, dynamic> json) {
    return LocationDto(
      name: json['name'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'country': country,
    };
  }
}