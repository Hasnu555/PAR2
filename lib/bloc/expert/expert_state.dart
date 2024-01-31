import 'package:equatable/equatable.dart';
import 'package:derviza_app/model/expert.dart';

abstract class ExpertState extends Equatable {
  const ExpertState();

  @override
  List<Object?> get props => [];
}

class ExpertInitial extends ExpertState {}

class ExpertLoading extends ExpertState {}

class ExpertLoaded extends ExpertState {
  final List<Expert> experts;

  ExpertLoaded(this.experts);

  @override
  List<Object?> get props => [experts];
}

class ExpertOperationSuccess extends ExpertState {
  final String message;

  ExpertOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ExpertError extends ExpertState {
  final String errorMessage;

  ExpertError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
