import 'dart:convert';
import 'package:group3_4030/classes/dataLoader.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'building.dart';
class AllStates extends ChangeNotifier {
  List <Building> _buildings = [];

  List get buildings => _buildings;
  DataLoader loader = DataLoader();

  AllStates() {
    readJson();
  }

  Future<void> readJson() async {
    List building_list;
    final String response =
    await rootBundle.loadString('assets/buildings.json');
    final data = await json.decode(response);
    building_list = data["buildings"];
    for (var element in building_list) {
      Building b = Building.fromJson(element);
      _buildings.add(b);
    }

    notifyListeners();
  }


  void changeBuildings(List<Building> newBuildings) {
    _buildings = newBuildings;
    notifyListeners();
  }

}

