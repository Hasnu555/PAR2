import 'package:derviza_app/model/cart.dart';
import 'package:derviza_app/model/product.dart';
import 'package:derviza_app/screen/cart_screen.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';

void main() {
  testWidgets('ProductCartItem Widget Test', (WidgetTester tester) async {
    final product = Product(
      index: '1',
      crop: 'Tomato',
      description: 'Fresh tomatoes',
      price: 5,
      temperatureRange: 20,
      moistureLevels: 50,
      sunlightExposure: 80,
      ratings: 3,
      seller: 'Farm Fresh',
      imagesUrl: [''],
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: ProductCartItem(
            cartItem: CartItem(product: product,quantity: 2), 
            onRemove: () {}, 
          ),
        ),
      ),
    );

    expect(find.text(product.crop), findsOneWidget);
    expect(find.text('Seller: ${product.seller}'), findsOneWidget);
    expect(find.text('Price: ${product.price}'), findsOneWidget);

    expect(find.byIcon(Icons.remove), findsOneWidget);

  });
}
