import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:cloud_firestore/cloud_firestore.dart';

class Crops extends Equatable {
  final String commodity;
  final int quantity;
  final int index;
  final String country;
  final DateTime date;
  charts.Color? barColor;

  Crops({
    required this.commodity,
    required this.index,
    required int quantity,
    required this.country,
    required this.date,
    this.barColor,
  }) : quantity = quantity.isNaN ? 0 : quantity.toInt() {
    barColor = charts.ColorUtil.fromDartColor(Color(0xFFFAD382));
  }

  @override
  List<Object?> get props => [commodity, index, quantity, country, date];

  static List<Crops> _cropsData = [];

  static Future<List<Crops>>? fetchDataFromFirestore() async {
    final QuerySnapshot<Map<String, dynamic>> snapshot =
        await FirebaseFirestore.instance.collection('crops').get();

    _cropsData = snapshot.docs
        .map((doc) {
          final data = doc.data();
          if (data['Commodity'] != null &&
              data['Index'] != null &&
              data['Quantity'] != null &&
              data['Country'] != null &&
              data['Date'] != null) {
            return Crops(
              commodity: data['Commodity'],
              index: data['Index'],
              quantity: data['Quantity'].toInt(),
              country: data['Country'],
              date: (data['Date'] as Timestamp).toDate(),
            );
          } else {
            return null;
          }
        })
        .whereType<Crops>() 
        .toList();

    return _cropsData;
  }

  static Future<List<Crops>> getFirebaseData() async {
    if (_cropsData.isEmpty) {
      await fetchDataFromFirestore();
    }
    return _cropsData;
  }
}
