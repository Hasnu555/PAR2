import 'dart:convert';
import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:derviza_app/model/cart.dart';
import 'package:derviza_app/model/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToCart(Product product, String userId) async {
    
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(product.index) 
        .set(product.toMap(), SetOptions(merge: true));
  }

  Future<void> removeFromCart(Product product, String userId) async {
    
    await _firestore
        .collection('carts')
        .doc(userId)
        .collection('items')
        .doc(product.index)
        .delete();
  }

  Future<Cart> getCart(String userId) async {
  try {
    final cartSnapshot = await FirebaseFirestore.instance
        .collection('carts')
        .doc(userId)
        .collection('items')
        .get();

    final List<CartItem> items = cartSnapshot.docs
        .map((doc) {
          final Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          if (data != null) {
            return CartItem(
              product: Product(
                index: doc.id,
                crop: data['crop'] ?? '',  
                description: data['description'] ?? '',
                price: data['price'] ?? 0.0,  
                temperatureRange: data['Temperature Range'] ?? 0,
                moistureLevels: data['Moisture Levels'] ?? 0,
                sunlightExposure: data['Sunlight'] ?? 0,
                ratings: data['ratings'] ?? 0,
                seller: data['Seller'] ?? '',
                imagesUrl: data['imagesUrl']?.cast<String>() ?? [],
              ),
              quantity: data['quantity'] ?? 0,  
            );
          } else {
            
  
            return CartItem(product: Product(index: '', crop: '',description: '',price: 2,temperatureRange: 21,moistureLevels: 31,sunlightExposure: 21,ratings:4,seller: 'fas', imagesUrl: [],), quantity: 0);
          }
        })
        .toList();

    return Cart(items: items);
  } catch (error) {
    print('Error fetching cart data: $error');
    
    throw error;
  }
}
}