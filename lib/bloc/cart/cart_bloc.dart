import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:derviza_app/bloc/cart/crop_event.dart';
import 'package:derviza_app/bloc/cart/crop_state.dart';
import 'package:derviza_app/repository/cart_repo.dart';
import 'package:derviza_app/model/product.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository cartRepository = CartRepository();
  final FirebaseAuth _auth = FirebaseAuth.instance;


  CartBloc() : super(CartLoadingState()) {
    on<LoadCartEvent>((event, emit) async {
      try {
          
        final user = _auth.currentUser;
        if (user != null) {
          final userId = user.uid;
          final cart = await cartRepository.getCart(userId);
          emit(CartLoadedState(cart: cart));
        }
      } catch (e) {
        print("Error loading cart: $e");
      }
    });

    on<AddToCartEvent>((event, emit) async {
  try {
    final user = _auth.currentUser;
    if (user != null) {
      final userId = user.uid;
      print(userId);
      await cartRepository.addToCart(event.product, userId);
      final updatedCart = await cartRepository.getCart(userId);
      emit(CartLoadedState(cart: updatedCart)); // Add this line
    }
  } catch (e) {
    print("Error adding to cart: $e");
  }
});


    on<RemoveFromCartEvent>((event, emit) async {
      try {
        final user = _auth.currentUser;
        if (user != null) {
          final userId = user.uid;
          await cartRepository.removeFromCart(event.product, userId);
          final updatedCart = await cartRepository.getCart(userId);
          emit(CartLoadedState(cart: updatedCart));
        }
      } catch (e) {
        print("Error removing from cart: $e");
      }
    });
  }
}
