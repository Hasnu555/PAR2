import 'package:derviza_app/model/product.dart';

class CartItem {
  final Product product;
  final int quantity;

  CartItem({required this.product, required this.quantity});
}

class Cart {
  final List<CartItem> items;

  Cart({required this.items});
}

