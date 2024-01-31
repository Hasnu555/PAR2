import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WalletRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addToWallet(double amount, String userId) async {
    
    await _firestore
        .collection('wallets')
        .doc(userId)
        .set({'balance': FieldValue.increment(amount)}, SetOptions(merge: true));
  }

  Future<void> withdrawFromWallet(double amount, String userId) async {
    
    await _firestore
        .collection('wallets')
        .doc(userId)
        .set({'balance': FieldValue.increment(-amount)}, SetOptions(merge: true));
  }

  Future<double> getWalletBalance(String userId) async {
    try {
      final walletSnapshot = await _firestore.collection('wallets').doc(userId).get();
      final Map<String, dynamic>? data = walletSnapshot.data() as Map<String, dynamic>?;

      if (data != null) {
        return data['balance'] ?? 0.0;  
      } else {
        return 0.0;
      }
    } catch (error) {
      print('Error fetching wallet balance: $error');
      throw error;
    }
  }
}
