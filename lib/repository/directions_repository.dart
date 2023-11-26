import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:devfest_hackaton/models/directions_model.dart';

// cle API pour google map
const API_KEY = "AIzaSyBKFCtcSQeE2P1t83omMy4Ddg2U-YtI_0k";

class DirectionRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;
  DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();

  // prendre tous les points venant de 'origin' allant dans la direction 'destination'
  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'key': API_KEY
      },
    );

    // check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
  }
}
