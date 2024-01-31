import 'package:derviza_app/bloc/crops/crops_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/model/crops.dart';



class CropsBloc extends Bloc<CropsEvent, CropsState> {
  final List<Crops> _cropsData = [];

  CropsBloc() : super(CropsInitial()) {
    on<LoadCrops>((event, emit) async {
      try {
        emit(CropsLoading());
        final crops = await Crops.getFirebaseData();
        _cropsData.clear();
        _cropsData.addAll(crops);
        emit(CropsLoaded(crops));
      } catch (e) {
        emit(CropsError('Failed to load crops.'));
      }
    });
  }
}