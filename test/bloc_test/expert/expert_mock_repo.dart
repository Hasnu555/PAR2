import 'dart:async';

import 'package:derviza_app/model/expert.dart';
import 'package:derviza_app/repository/expert_repo.dart';

class MockExpertRepository implements ExpertFirestoreService {
  @override
  Stream<List<Expert>> getExperts() {
    // Return a stream of a list of mock experts for testing.
    return Stream.fromIterable([
      [
        Expert(
          id: '1',
          name: 'Test Expert 1',
          imagesUrl: 'https://example.com/image1.jpg',
          experience: 5,
          rating: 4.5,
          speciality: 'Test Speciality 1',
          description: 'Test Description 1',
        ),
        Expert(
          id: '2',
          name: 'Test Expert 2',
          imagesUrl: 'https://example.com/image2.jpg',
          experience: 3,
          rating: 4.0,
          speciality: 'Test Speciality 2',
          description: 'Test Description 2',
        ),
      ]
    ]);
  }

  void addExpert(Expert expert) {
    // Mock implementation for adding an expert.
    // You can perform validation or check for errors here if needed.
  }

  void updateExpert(Expert expert) {
    // Mock implementation for updating an expert.
    // You can perform validation or check for errors here if needed.
  }
}
