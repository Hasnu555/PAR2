import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derviza_app/model/product.dart';

class ProductFirestoreService {
  final CollectionReference _productsCollection =
  FirebaseFirestore.instance.collection('sellcrops');

  Stream<List<Product>> getProducts() {
    return _productsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        return Product(
          index: doc.id,
          crop: data['crop'],
          description: data['description'],
          price: data['price'],
          temperatureRange: data['Temperature Range'],
          moistureLevels: data['Moisture Levels'],
          ratings: data['ratings'],
          sunlightExposure: data['Sunlight'],
          seller: data['Seller'],
          imagesUrl: data['imagesUrl'].cast<String>(),
        );
          
      }).toList();
    });
  }

  
}