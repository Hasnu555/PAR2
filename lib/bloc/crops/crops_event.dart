import 'package:derviza_app/model/crops.dart';
import 'package:equatable/equatable.dart';

class CropsEvent {}

class LoadCrops extends CropsEvent {}

abstract class CropsState extends Equatable {
  const CropsState();

  @override
  List<Object?> get props => [];
}

class CropsInitial extends CropsState {}

class CropsLoading extends CropsState {}

class CropsLoaded extends CropsState {
  final List<Crops> crops;

  CropsLoaded(this.crops);

  @override
  List<Object?> get props => [crops];
}

class CropsError extends CropsState {
  final String errorMessage;

  CropsError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}