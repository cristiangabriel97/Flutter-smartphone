import 'package:cloud_firestore/cloud_firestore.dart';

class SmartphoneRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addSmartphone(Map<String, dynamic> smartphoneData) async {
    await _firestore.collection('smartphones').add(smartphoneData);
  }

  Stream<List<Map<String, dynamic>>> getSmartphones() {
    return _firestore.collection('smartphones').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return data;
      }).toList();
    });
  }
}
