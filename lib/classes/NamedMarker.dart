import 'package:google_maps_flutter/google_maps_flutter.dart';
class NamedMarker {
  Marker marker;
  String name;
  String abrv;

  NamedMarker({
    required this.marker,
    required this.name,
    required this.abrv,
  });
}