import 'dart:async';

import 'package:agriapp/presentation/screens/get_farm/get_farm_name_screen.dart';
import 'package:agriapp/presentation/widgets/form/custom_text_form_field.dart';
import 'package:agriapp/theme.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetFarmMapWidget extends StatefulWidget {
  const GetFarmMapWidget({Key? key, required this.data, required this.googleController, required this.moveToCurrentLocation}) : super(key: key);

  final CameraPosition? data;
  final Completer<GoogleMapController> googleController;
  final VoidCallback moveToCurrentLocation;

  @override
  State<GetFarmMapWidget> createState() => _GetFarmMapWidgetState();
}

class _GetFarmMapWidgetState extends State<GetFarmMapWidget> {
  final CameraPosition kFaisalTown = const CameraPosition(target: LatLng(31.0, 74.0), zoom: 16);

  CameraPosition? cameraPosition;

  final List<LatLng> polygonCoordinates = [];

  _onTap(LatLng coords) {
    setState(() {
      polygonCoordinates.add(coords);
    });
  }

  _onClear() {
    setState(() {
      polygonCoordinates.removeLast();
    });
  }

  _onSave() {
    if (polygonCoordinates.length > 2) Navigator.of(context).push(MaterialPageRoute(builder: (context) => GetFarmNameScreen(coordinates: polygonCoordinates)));
  }

  @override
  void initState() {
    super.initState();

    cameraPosition = widget.data;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: cameraPosition != null ? cameraPosition! : kFaisalTown,
          onMapCreated: (GoogleMapController controller) => widget.googleController.complete(controller),
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          myLocationEnabled: true,
          markers: polygonCoordinates.map((e) => Marker(markerId: MarkerId(e.toString()), position: e)).toSet(),
          polygons: {
            if (polygonCoordinates.length > 2)
              Polygon(
                polygonId: const PolygonId('polygon'),
                points: polygonCoordinates,
                geodesic: true,
                strokeWidth: 1,
                fillColor: Colors.black38,
                strokeColor: Colors.blue,
              ),
          },
          onTap: _onTap,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextFormField(
                controller: TextEditingController(),
                text: 'Search Place',
                suffixIcon: const Padding(padding: EdgeInsets.only(right: 8.0), child: Icon(Icons.search)),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _onClear,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Text(
                        'CLEAR',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: lightGreenColor, fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(width: 25),
                  InkWell(
                    onTap: _onSave,
                    child: Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.white),
                      width: 100,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: const Text(
                        'SAVE',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: lightGreenColor, fontSize: 15, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          right: 0,
          bottom: 0,
          child: InkWell(
            onTap: widget.moveToCurrentLocation,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: Colors.white),
              child: const Icon(Icons.my_location, color: Colors.black45, size: 20),
            ),
          ),
        ),
      ],
    );
  }
}
