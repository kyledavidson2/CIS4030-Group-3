import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

Set<Marker> markers = {};

Set<Marker> setMarkers()
{
  getCoordinates();
  return markers;
}

Future<void> getCoordinates() async{
  
  final coordinatesResponse = await http.get(Uri.parse('http://35.172.228.146:8000/getbuilding'));
  final coordinates = await json.decode(coordinatesResponse.body);
 
  for (var element in coordinates) 
  {
    if(element['abrv']!= "ZAV")
    {
    markers.add(Marker(
      markerId: MarkerId(element['abrv']),
      position: LatLng(element['lat'], element['long'])
      ));
    }
  }
  
}



