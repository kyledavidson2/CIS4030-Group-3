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

  Future<void> refreshBuildings() async{
    _buildings = [];
    await readJson();
    notifyListeners();
  }

  Future<void> setBuildings(List<Building> buildings)async{
    _buildings = buildings;
    notifyListeners();
  }

  Future<void> readJson() async {
    List building_list;
    // try:
      BuildingData b = BuildingData();
      final http.Response r = await b.getBuildings();
      final data = await json.decode(r.body);
    // Exception:
    //   final String response =
    //    await rootBundle.loadString('assets/buildings.json');
    //   final data = await json.decode(response);
    building_list = data;
    for (var element in building_list) {
      Building b = Building.fromJson(element);
      _buildings.add(b);
    }

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

