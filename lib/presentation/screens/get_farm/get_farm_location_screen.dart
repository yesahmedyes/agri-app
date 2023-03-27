import 'dart:async';

import 'package:agriapp/presentation/screens/get_farm/widgets/get_farm_map.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetFarmLocationScreen extends StatelessWidget {
  GetFarmLocationScreen({super.key});

  final Completer<GoogleMapController> googleController = Completer<GoogleMapController>();

  _getUserPermission() async {
    await Geolocator.requestPermission();
  }

  Future<CameraPosition> _getUserCurrentLocation() async {
    _getUserPermission();

    final value = await Geolocator.getCurrentPosition();

    return CameraPosition(target: LatLng(value.latitude, value.longitude), zoom: 16);
  }

  moveToCurrentLocation() async {
    final cameraPosition = await _getUserCurrentLocation();

    final GoogleMapController controller = await googleController.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: _getUserCurrentLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return GetFarmMapWidget(
              data: snapshot.data,
              googleController: googleController,
              moveToCurrentLocation: moveToCurrentLocation,
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
