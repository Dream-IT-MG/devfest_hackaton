import 'package:devfest_hackaton/models/station.dart';
import 'package:devfest_hackaton/services/station_services.dart';
import 'package:flutter/material.dart';

class SearchViewModels extends ChangeNotifier {
  final TextEditingController query = TextEditingController();
  List<Station> stationsList = [
    Station(name: "67_HA", heureArrive: "06:00_AM"),
    Station(name: "Ambohijatovo", heureArrive: "06:20_AM"),
    Station(name: "Analakely", heureArrive: "06:05_PM"),
    Station(name: "Ambanidia", heureArrive: "09:15_AM"),
    Station(name: "Anosy", heureArrive: "01:25_PM"),
    Station(name: "Analamahitsy", heureArrive: "09:15_AM"),
    Station(name: "Anosy", heureArrive: "01:25_PM"),
  ];

  void updateQuery(String newText) {
    query.text = newText;
    notifyListeners();
  }

  List<Station> getFilteredStations() {
    return StationService.getFilteredStations(query.text, stationsList);
  }

  void toggleStationNotified(Station station) {
    final stationIndex =
        stationsList.indexWhere((element) => station.name == element.name);
    if (stationIndex != -1) {
      stationsList[stationIndex].isNotified =
          !stationsList[stationIndex].isNotified;
      notifyListeners();
    }
  }
}
