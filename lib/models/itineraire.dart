import 'package:devfest_hackaton/models/point.dart';

class Itineraire {
  String heureTotalDuTrajet;
  List<Point> listDesPointAParcourir;

  Itineraire({
    required this.heureTotalDuTrajet,
    required this.listDesPointAParcourir,
  });
}
