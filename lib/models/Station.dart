import 'dart:convert';

class Station {
  String name;
  String heureArrive;
  bool isNotified;

  Station({
    required this.name,
    required this.heureArrive,
    this.isNotified = false,
  });

  factory Station.fromRawJson(String str) => Station.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Station.fromJson(Map<String, dynamic> json) => Station(
        name: json["name"],
        heureArrive: json["heure_arrive"],
        isNotified: json["is_notified"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "heure_arrive": heureArrive,
        "is_notified": isNotified,
      };
}
