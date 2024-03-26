import "room.dart";

class Floor {
  int level = 0;
  List<Room> rooms = [];

  Floor({
    required this.level,
    required this.rooms,
  });
  
  Floor.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    if (json['rooms'] != null) {
      rooms = <Room>[];
      json['rooms'].forEach((v) {
        rooms.add(Room.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['level'] = this.level;
    if (this.rooms != null) {
      data['rooms'] = this.rooms!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString(){
    switch(level){
      case 0:
        return "Ground Floor";
      case 1:
        return "1st Floor";
      case 2:
        return "2nd Floor";
      case 3:
        return "3rd Floor";
      default:
        return "${level}th Floor";
    }
  }
}
