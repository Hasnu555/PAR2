import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _cropsCollection =
      FirebaseFirestore.instance.collection('crops');

  Future<List<Map<String, dynamic>>> getFirebaseData() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await _cropsCollection.get() as QuerySnapshot<Map<String, dynamic>>;

    return snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();
  }
}
