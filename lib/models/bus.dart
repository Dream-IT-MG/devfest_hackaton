import 'dart:convert';

class Bus {
  String id;
  String arret;
  String heureArrivee;
  String prochaineArrivee;

  Bus({
    required this.id,
    required this.arret,
    required this.heureArrivee,
    required this.prochaineArrivee,
  });

  factory Bus.fromRawJson(String str) => Bus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        arret: json["arret"],
        heureArrivee: json["heureArrivee"],
        prochaineArrivee: json["prochaineArrivee"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "arret": arret,
        "heureArrivee": heureArrivee,
        "prochaineArrivee": prochaineArrivee,
      };
}
