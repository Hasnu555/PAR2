import 'package:derviza_app/model/product.dart';
import 'package:equatable/equatable.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class LoadCartEvent extends CartEvent {
  @override
  List<Object?> get props => [];
}


class AddToCartEvent extends CartEvent {
  final Product product;

  AddToCartEvent({required this.product});

  @override
  List<Object?> get props => [product];
}

class RemoveFromCartEvent extends CartEvent {
  final Product product;

  RemoveFromCartEvent({required this.product});

  @override
  List<Object?> get props => [product];
}


