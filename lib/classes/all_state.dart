import 'dart:convert';
import 'package:group3_4030/classes/dataLoader.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'building.dart';
class AllStates extends ChangeNotifier {
  List <Building> _buildings = [];

  List<Building> get buildings => _buildings;
  DataLoader loader = DataLoader();

  AllStates() {
    readJson();
  }

  Future<http.Response> getBuildings(){
    return http.get(Uri.parse('http://35.172.228.146:8000/getbuilding'));
  }

  Future<void> readJson() async {
    List building_list;

    //final String response =
    //  await rootBundle.loadString('assets/buildings.json');
    //final data = await json.decode(response);

    final http.Response r = await getBuildings();
    final data = await json.decode(r.body);

    building_list = data;
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

