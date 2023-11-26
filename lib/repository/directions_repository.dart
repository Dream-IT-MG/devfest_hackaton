import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/directions_model.dart';

class DirectionRepository {
  static const String _baseUrl =
      'https://maps.googleapis.com/maps/api/directions/json?';

  final Dio _dio;
  DirectionRepository({Dio? dio}) : _dio = dio ?? Dio();

  Future<Directions?> getDirections({
    required LatLng origin,
    required LatLng destination,
  }) async {
    print("_______________________________");
    print("avant await");
    print("__________________etoooooooooooooooooooo______________");
    final response = await _dio.get(
      _baseUrl,
      queryParameters: {
        'origin': '${origin.latitude}, ${origin.longitude}',
        'destination': '${destination.latitude}, ${destination.longitude}',
        'key': 'AIzaSyBKFCtcSQeE2P1t83omMy4Ddg2U-YtI_0k'
      },
    );
    print("_______________________________");
    print(response);
    print("__________________etoooooooooooooooooooo______________");

    // check if response is successful
    if (response.statusCode == 200) {
      return Directions.fromMap(response.data);
    }
    // return null;
  }
}
