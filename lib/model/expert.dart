import 'package:equatable/equatable.dart';

class Expert extends Equatable {
  final String id;
  final String name;
  final String imagesUrl;
  final int experience;
  final double rating;
  final String speciality;
  final String description;
  // final int number;
  
  Expert({
    required this.id,
    required this.name,
    required this.imagesUrl,
    required this.experience,
    required this.rating,
    required this.speciality,
    
    required this.description,
    // required this.number,
  });

  @override
  List<Object?> get props => [id, name, imagesUrl, experience, rating, speciality];

  factory Expert.fromMap(Map<String, dynamic> map) {
    return Expert(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      imagesUrl: map['imagesUrl'] ?? '',
      experience: map['experience'] ?? 0,
      rating: map['rating'] ?? 0,
      speciality: map['speciality'] ?? '',
      description: map['description'] ?? '',
      // number: map['number'] ?? 0,
      
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'imagesUrl': imagesUrl,
      'experience': experience,
      'rating': rating,
      'speciality': speciality,
      'description': description,
      // 'number': number,
      
    };
  }
}
