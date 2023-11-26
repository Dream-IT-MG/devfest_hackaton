import 'package:devfest_hackaton/models/bus.dart';
import 'package:flutter/material.dart';

class GoogleMapViewModels extends ChangeNotifier {
  List<Bus> buses = [
    Bus(
        id: "139",
        arret: "Analakely",
        heureArrivee: "14H40",
        prochaineArrivee: "14H"),
    Bus(
        id: "127",
        arret: "Mahamasina",
        heureArrivee: "13H36",
        prochaineArrivee: "13h55"),
    Bus(
        id: "015",
        arret: "Ambohijatovo",
        heureArrivee: "13h55",
        prochaineArrivee: "13H59"),
  ];
}
