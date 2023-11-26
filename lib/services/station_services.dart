import 'package:devfest_hackaton/models/station.dart';

class StationService {
  static List<Station> getFilteredStations(
      String query, List<Station> stationsList) {
    if (query.isEmpty) {
      return stationsList;
    } else {
      return stationsList
          .where(
              (item) => item.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}
