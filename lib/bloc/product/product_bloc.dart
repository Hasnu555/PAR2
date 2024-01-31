import 'package:derviza_app/bloc/product/product_event.dart';
import 'package:derviza_app/bloc/product/product_state.dart';
import 'package:derviza_app/repository/product_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductFirestoreService _firestoreService;

  ProductBloc(this._firestoreService) : super(ProductInitial()) {
    on<LoadProduct>((event, emit) async {
      try {
        emit(ProductLoading());
        final products = await _firestoreService.getProducts().first;
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products.'));
      }
    });

    

  }
}