
import 'dart:convert';

import 'package:http/http.dart' as http;

class BuildingData{

  String baseUrl = "http://3.95.246.42:8000/";

  Future<http.Response> getBuildingById(int id) {
    return http.post(
      Uri.parse('$baseUrl/getbuildingbyid'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'id': id.toString(),
      }),
    );
  }

  Future<http.Response> getBuildings() {
    return http.get(Uri.parse('$baseUrl/getbuilding'));
  }



}