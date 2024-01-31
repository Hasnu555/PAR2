import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String index;
  final String crop;
  final String description;
  final int price;
  final int temperatureRange;
  final int moistureLevels;
  final int sunlightExposure;
  final double ratings;
  final String seller;
  final List<String> imagesUrl;

  Product({
    required this.index,
    required this.crop,
    required this.description,
    required this.price,
    required this.temperatureRange,
    required this.moistureLevels,
    required this.sunlightExposure,
    required this.ratings,
    required this.seller,
    required this.imagesUrl,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      index: map['index'] ?? '',
      crop: map['crop'] ?? '',
      description: map['description'] ?? '',
      price: map['price'] ?? 0,
      temperatureRange: map['Temperature Range'] ?? 0,
      moistureLevels: map['Moisture Levels'] ?? 0,
      sunlightExposure: map['Sunlight Exposure'] ?? 0,
      ratings: map['rating'] ?? 0,
      seller: map['Seller'] ?? '',
      imagesUrl: map['imagesUrl']?.cast<String>() ?? [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'index': index,
      'crop': crop,
      'description': description,
      'price': price,
      'Temperature Range': temperatureRange,
      'Moisture Levels': moistureLevels,
      'Sunlight Exposure': sunlightExposure,
      'ratings': ratings,
      'Seller': seller,
      'imagesUrl': imagesUrl,
    };
  }

  @override
  List<Object?> get props => [
        index,
        crop,
        description,
        price,
        temperatureRange,
        moistureLevels,
        sunlightExposure,
        ratings,
        seller,
        imagesUrl,
      ];
}
