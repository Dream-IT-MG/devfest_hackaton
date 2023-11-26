import 'package:devfest_hackaton/models/bus.dart';
import 'package:devfest_hackaton/models/station.dart';

class Point {
  Bus bus;
  Station station;
  String heureArriverSurLieu;

  Point({
    required this.bus,
    required this.station,
    required this.heureArriverSurLieu,
  });
}
