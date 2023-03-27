import 'package:google_maps_flutter/google_maps_flutter.dart';

class Farm {
  final String id;
  final String name;
  final List<LatLng> coordinates;

  Farm({required this.id, required this.name, required this.coordinates});
}
