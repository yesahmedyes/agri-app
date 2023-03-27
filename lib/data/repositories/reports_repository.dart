import 'package:agriapp/data/models/report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportsRepository {
  final FirebaseFirestore firebaseFirestore;

  ReportsRepository() : firebaseFirestore = FirebaseFirestore.instance;

  Future<Report?> getReport(String farmId) async {
    final doc = await firebaseFirestore.collection('reports').doc(farmId).get();

    if (doc.exists) {
      final data = doc.data();

      if (data != null) {
        final Timestamp timestamp = data['createdAt'];

        return Report(
          createdAt: DateTime.fromMicrosecondsSinceEpoch(timestamp.microsecondsSinceEpoch),
          water: data['water'],
          nitrogen: data['nitrogen'],
        );
      }
    }

    return null;
  }
}
