import "floor.dart";

class Building {
  String name = "";
  String abrv = "";
  List<Floor> floors = [];

  Building({
    required this.name,
    required this.abrv,
    required this.floors,
  });

  Building.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    abrv = json['abrv'];
    if (json['floors'] != null) {
      floors = <Floor>[];
      json['floors'].forEach((v) {
        floors.add(Floor.fromJson(v));
      });
    }
  }
}
