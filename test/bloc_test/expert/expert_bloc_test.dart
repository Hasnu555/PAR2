import 'package:bloc_test/bloc_test.dart';
import 'package:derviza_app/bloc/expert/expert_bloc.dart'; // Adjust the import to your actual expert_bloc.dart file.
import 'package:derviza_app/bloc/expert/expert_event.dart'; // Adjust the import to your actual expert_event.dart file.
import 'package:derviza_app/bloc/expert/expert_state.dart'; // Adjust the import to your actual expert_state.dart file.
import 'package:derviza_app/model/expert.dart'; // Adjust the import to your actual expert.dart file.
import 'package:flutter_test/flutter_test.dart';

import 'expert_mock_repo.dart';

void main() {
  group('ExpertBloc', () {
    late ExpertBloc expertBloc;

    setUp(() {
      expertBloc = ExpertBloc(MockExpertRepository()); // Use the mock repository here.
    });

    tearDown(() {
      expertBloc.close();
    });

    blocTest<ExpertBloc, ExpertState>(
      'emits [ExpertLoading, ExpertLoaded] when LoadExperts event is added',
      build: () => expertBloc,
      act: (bloc) => bloc.add(LoadExperts()),
      expect: () => [
        ExpertLoading(),
        ExpertLoaded([
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
        ]),
      ],
    );

    // Add more tests for other events and states as needed.
  });
}
