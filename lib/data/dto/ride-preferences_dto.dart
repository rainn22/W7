import 'dart:convert';
import 'package:week_3_blabla_project/data/dto/location_dto.dart';

class RidePreferenceDto {
  final String id;
  final LocationDto location;
  RidePreferenceDto({required this.id, required this.location});

  static RidePreferenceDto fromJson(String json) {
    final Map<String, dynamic> data = jsonDecode(json);
    return RidePreferenceDto(
      id: data['id'],
      location: LocationDto.fromJson(data['location']),
    );
  }

  String toJson() {
    final Map<String, dynamic> data = {
      'id': id,
      'location': location.toJson(),
    };
    return jsonEncode(data); // Convert to JSON string
  }
}