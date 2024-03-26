import "floor.dart";

class Building {
  String name = "";
  String abrv = "";
  List<Floor> floors = [];
  int id = -1;
  double lat = 0.0;
  double long = 0.0;

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
    id = json['id'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['abrv'] = abrv;
    if (this.floors != null) {
      data['floors'] = this.floors!.map((v) => v.toJson()).toList();
    }
    data['id'] = id;
    data['lat'] = lat;
    data['long'] = long;

    return data;
  }

  int firstFloor(){
    return floors.first.level;
  }

  int lastFloor(){
    return floors.last.level;
  }
}
