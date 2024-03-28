import 'dart:convert';
// import 'package:group3_4030/classes/dataLoader.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'building.dart';
import 'buildingData.dart';
class AllStates extends ChangeNotifier {
  List <Building> _buildings = [];

  List<Building> get buildings => _buildings;
  // DataLoader loader = DataLoader();

  AllStates() {
    readJson();
  }

  void refreshBuildings(){
    readJson();
  }


  Future<void> readJson() async {
    List building_list;

    //final String response =
    //  await rootBundle.loadString('assets/buildings.json');
    //final data = await json.decode(response);
    BuildingData b = BuildingData();
    final http.Response r = await b.getBuildings();
    final data = await json.decode(r.body);

    building_list = data;
    for (var element in building_list) {
      Building b = Building.fromJson(element);
      _buildings.add(b);
    }

    notifyListeners();
  }

  Building? getBuildingById(String id){
    for (var element in _buildings){
      if (element.id == int.parse(id)){
        return element;
      }
    }
    return null;
  }


  void changeBuildings(List<Building> newBuildings) {
    _buildings = newBuildings;
    notifyListeners();
  }

}

