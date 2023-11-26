import 'dart:convert';

class Bus {
  String id;
  String arret;

  Bus({
    required this.id,
    required this.arret,
  });

  factory Bus.fromRawJson(String str) => Bus.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Bus.fromJson(Map<String, dynamic> json) => Bus(
        id: json["id"],
        arret: json["arret"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "arret": arret,
      };
}
