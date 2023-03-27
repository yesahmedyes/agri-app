import 'dart:async';

import 'package:agriapp/data/models/farm.dart';
import 'package:agriapp/presentation/screens/reports/bloc/farm_select_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class FarmMapWidget extends StatelessWidget {
  final List<Farm> farms;

  FarmMapWidget({super.key, required this.farms});

  late GoogleMapController _googleMapController;

  _updateCameraPosition(List<LatLng> points) async {
    double minLat = points.first.latitude;
    double minLong = points.first.longitude;
    double maxLat = points.first.latitude;
    double maxLong = points.first.longitude;

    for (var poly in points) {
      for (var point in points) {
        if (point.latitude < minLat) minLat = point.latitude;
        if (point.latitude > maxLat) maxLat = point.latitude;
        if (point.longitude < minLong) minLong = point.longitude;
        if (point.longitude > maxLong) maxLong = point.longitude;
      }
    }

    await _googleMapController.moveCamera(
      CameraUpdate.newLatLngBounds(LatLngBounds(southwest: LatLng(minLat, minLong), northeast: LatLng(maxLat, maxLong)), 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FarmSelectBloc, FarmSelectState>(
      listener: (context, state) {
        if (state is FarmSelectedState) {
          final Farm farm = farms.firstWhere((each) => (each.name == state.name));

          _updateCameraPosition(farm.coordinates);
        }
      },
      listenWhen: (previous, current) => (previous is FarmSelectedState && current is FarmSelectedState),
      builder: (context, state) {
        if (state is FarmSelectedState) {
          final Farm farm = farms.firstWhere((each) => (each.name == state.name));

          return Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), border: Border.all(color: Colors.grey)),
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 4),
            child: AspectRatio(
              aspectRatio: 3 / 2,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: GoogleMap(
                  mapType: MapType.hybrid,
                  initialCameraPosition: const CameraPosition(target: LatLng(31.0, 74.0), zoom: 16),
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) async {
                    WidgetsBinding.instance.addPostFrameCallback((_) async {
                      _googleMapController = controller;

                      await Future.delayed(const Duration(seconds: 1));

                      _updateCameraPosition(farm.coordinates);
                    });
                  },
                  polygons: {
                    Polygon(
                      polygonId: const PolygonId('polygon'),
                      points: farm.coordinates,
                      geodesic: true,
                      strokeWidth: 1,
                      fillColor: Colors.black38,
                      strokeColor: Colors.blue,
                    ),
                  },
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
