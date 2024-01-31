import 'package:equatable/equatable.dart';
import 'package:derviza_app/model/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductOperationSuccess extends ProductState {
  final String message;

  ProductOperationSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ProductError extends ProductState {
  final String errorMessage;

  ProductError(this.errorMessage);

  @override
  List<Object?> get props => [errorMessage];
}
