import 'package:agriapp/data/models/farm.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';

class FarmRepository {
  final FirebaseFirestore firebaseFirestore;
  final FirebaseAuth firebaseAuth;

  FarmRepository()
      : firebaseAuth = FirebaseAuth.instance,
        firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Farm>> getAllFarms() async {
    final uid = firebaseAuth.currentUser?.uid;

    final List<Farm> farms = [];

    if (uid == null) return farms;

    final doc = await firebaseFirestore.collection('farms').doc(uid).get();

    if (doc.exists) {
      final data = doc.data();

      if (data != null) {
        final List farmsList = data['farm'];

        for (var element in farmsList) {
          final List coordinates = element['coordinates'];

          farms.add(
            Farm(
              id: element['id'],
              name: element['name'],
              coordinates: coordinates.map((e) => LatLng(e.latitude, e.longitude)).toList(),
            ),
          );
        }
      }
    }

    return farms;
  }

  Future<void> saveFarm(List<LatLng> coordinates, String name) async {
    final uid = firebaseAuth.currentUser?.uid;

    if (uid == null) return;

    final doc = await firebaseFirestore.collection('farms').doc(uid).get();

    final map = {
      'id': const Uuid().v1(),
      'name': name,
      'coordinates': coordinates.map((each) => GeoPoint(each.latitude, each.longitude)).toList(),
    };

    if (doc.exists) {
      await firebaseFirestore.collection('farms').doc(uid).update({
        'farm': FieldValue.arrayUnion([map])
      });
    } else {
      await firebaseFirestore.collection('farms').doc(uid).set({
        'farm': [map]
      });
    }
  }
}
