import 'package:devfest_hackaton/models/bus.dart';
import 'package:devfest_hackaton/models/itineraire.dart';
import 'package:devfest_hackaton/models/point.dart';
import 'package:devfest_hackaton/models/station.dart';
import 'package:flutter/material.dart';

class GoogleMapViewModels extends ChangeNotifier {
  List<Itineraire> itineraires = [
    Itineraire(heureTotalDuTrajet: "02H", listDesPointAParcourir: [
      Point(
        bus: Bus(id: "139", arret: "Analakely"),
        station: Station(name: "Analakely", heureArrive: "13H36"),
        heureArriverSurLieu: "13H30",
      ),
      Point(
        bus: Bus(id: "127", arret: "Antanimena"),
        station: Station(
          name: "Antanimena",
          heureArrive: "13H46",
        ),
        heureArriverSurLieu: "13H47",
      ),
      Point(
        bus: Bus(id: "160", arret: "Ankatso"),
        station: Station(name: "Ankatso", heureArrive: "13H36"),
        heureArriverSurLieu: "13H58",
      ),
      Point(
        bus: Bus(id: "128", arret: "Mahamasina"),
        station: Station(name: "Mahamasina", heureArrive: "13H36"),
        heureArriverSurLieu: "14H10",
      ),
    ]),
    Itineraire(heureTotalDuTrajet: "04H", listDesPointAParcourir: [
      Point(
        bus: Bus(id: "139", arret: "Analakely"),
        station: Station(name: "Analakely", heureArrive: "13H36"),
        heureArriverSurLieu: "13H30",
      ),
      Point(
        bus: Bus(id: "127", arret: "Antanimena"),
        station: Station(
          name: "Antanimena",
          heureArrive: "13H46",
        ),
        heureArriverSurLieu: "13H47",
      ),
      Point(
        bus: Bus(id: "160", arret: "Ankatso"),
        station: Station(name: "Ankatso", heureArrive: "13H36"),
        heureArriverSurLieu: "13H58",
      ),
      Point(
        bus: Bus(id: "128", arret: "Mahamasina"),
        station: Station(name: "Mahamasina", heureArrive: "13H36"),
        heureArriverSurLieu: "14H10",
      ),
      Point(
        bus: Bus(id: "127", arret: "Antanimena"),
        station: Station(
          name: "Antanimena",
          heureArrive: "14H35",
        ),
        heureArriverSurLieu: "14H30",
      ),
      Point(
        bus: Bus(id: "128", arret: "Mahamasina"),
        station: Station(name: "Mahamasina", heureArrive: "14H%)"),
        heureArriverSurLieu: "1440",
      ),
      Point(
        bus: Bus(id: "128", arret: "Ambohijatovo"),
        station: Station(name: "Ambohijatovo", heureArrive: "16H"),
        heureArriverSurLieu: "16H",
      ),
    ]),
    Itineraire(heureTotalDuTrajet: "06H", listDesPointAParcourir: [
      Point(
        bus: Bus(id: "139", arret: "Analakely"),
        station: Station(name: "Analakely", heureArrive: "13H36"),
        heureArriverSurLieu: "13H30",
      ),
      Point(
        bus: Bus(id: "127", arret: "Antanimena"),
        station: Station(
          name: "Antanimena",
          heureArrive: "15H15",
        ),
        heureArriverSurLieu: "16H15",
      ),
      Point(
        bus: Bus(id: "160", arret: "Ankatso"),
        station: Station(name: "Ankatso", heureArrive: "16H30"),
        heureArriverSurLieu: "17H10",
      ),
      Point(
        bus: Bus(id: "128", arret: "Mahamasina"),
        station: Station(name: "Mahamasina", heureArrive: "16H"),
        heureArriverSurLieu: "17H30",
      ),
    ]),
  ];

  int selectedBusId = 0;
  int selectedItineraire = 0;

  void updateSelecteItineraire(index) {
    selectedItineraire = index;
    notifyListeners();
  }

  void updateSelecteBusId(index) {
    selectedItineraire = index;
    notifyListeners();
  }
}
