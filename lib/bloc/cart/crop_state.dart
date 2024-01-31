import 'package:derviza_app/model/cart.dart';
import 'package:equatable/equatable.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartLoadingState extends CartState {
  @override
  List<Object?> get props => [];
}

class CartLoadedState extends CartState {
  final Cart cart;

  CartLoadedState({required this.cart});

  @override
  List<Object?> get props => [cart];
}
