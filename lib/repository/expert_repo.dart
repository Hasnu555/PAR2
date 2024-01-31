import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derviza_app/model/expert.dart';

class ExpertFirestoreService {
  final CollectionReference _expertsCollection =
      FirebaseFirestore.instance.collection('experts');

  Stream<List<Expert >> getExperts() {
        
    return _expertsCollection.snapshots().map((snapshot) {
      
      return snapshot.docs.map((doc) {
        
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        
        return Expert(
          id: doc.id,
          name: data['name'],
          imagesUrl: data['imagesUrl'],
          experience: data['experience'],
          rating: data['rating'],
          speciality: data['speciality'],
          description: data['description'],
          // number: data['number'],
          
        );
      }).toList();
    });
  }

}
