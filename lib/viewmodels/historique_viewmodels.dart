import 'package:devfest_hackaton/models/trajet.dart';
import 'package:flutter/cupertino.dart';

class HistoriqueViewModels extends ChangeNotifier {
  List<Trajet> trajetListe = [
    Trajet(depart: "Analakely", arrive: 'Anosy', fees: "600 Ar"),
    Trajet(depart: "Analakely", arrive: 'Tsimbazaza', fees: "1000 Ar"),
    Trajet(depart: "Ambohimiadana", arrive: 'Anosy', fees: "600 Ar"),
    Trajet(depart: "Manakambahiny", arrive: 'Anosy', fees: "1200 Ar"),
    Trajet(depart: "Analakely", arrive: 'Ambohijatovo', fees: "500 Ar"),
    Trajet(depart: "Ankatso", arrive: 'Anosy', fees: "800Ar"),
    Trajet(depart: "Andranomena", arrive: 'Andohatapenaka', fees: "1200 Ar"),
    Trajet(depart: "Ambohimanarina", arrive: 'Alarobia', fees: "2500 Ar"),
    Trajet(depart: "Ambatobe", arrive: 'Zoma', fees: "600Ar"),
    Trajet(depart: "Vassaccos", arrive: 'Sabotsy', fees: "500Ar"),
    Trajet(depart: "Analakely", arrive: 'Alatsinainy', fees: "0Ar"),
    Trajet(depart: "Ivato", arrive: 'Talata', fees: "600 Ar"),
    Trajet(depart: "Analakely", arrive: 'Anosy', fees: "1800 Ar"),
  ];
}
