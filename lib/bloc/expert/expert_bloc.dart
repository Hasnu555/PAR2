import 'package:derviza_app/bloc/expert/expert_event.dart';
import 'package:derviza_app/bloc/expert/expert_state.dart';
import 'package:derviza_app/repository/expert_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ExpertBloc extends Bloc<ExpertEvent, ExpertState> {
  final ExpertFirestoreService _firestoreService;

  ExpertBloc(this._firestoreService) : super(ExpertInitial()) {
    on<LoadExperts>((event, emit) async {
      try {
        emit(ExpertLoading());
        
        final experts = await _firestoreService.getExperts().first;
        print("Loading experts");
        
        emit(ExpertLoaded(experts));
      } catch (e) {
        emit(ExpertError('Failed to load experts.'));
      }
    });

    // Define other event handlers for ExpertBloc here if needed
  }
}
