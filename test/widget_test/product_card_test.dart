import 'package:derviza_app/bloc/cart/cart_bloc.dart';
import 'package:derviza_app/widgets/productcard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:derviza_app/model/product.dart';
import 'package:bloc/bloc.dart';

void main() {
  testWidgets('ProductCard Widget Test', (WidgetTester tester) async {
    Product testProduct = Product(
      index: '1',
      crop: 'Rice',
      description: 'Sample description',
      price: 100,
      temperatureRange: 25,
      moistureLevels: 60,
      sunlightExposure: 8,
      ratings: 2,
      seller: 'Sample Seller',
      imagesUrl: ['image_url_1', 'image_url_2'],
    );

    final cartBloc = CartBloc();

    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider.value(
          value: cartBloc,
          child: ProductCard(product: testProduct),
        ),
      ),
    );

    expect(find.text('Rice'), findsOneWidget);

    expect(find.text('Sample description...'), findsOneWidget);

    expect(find.text(' 100'), findsOneWidget);

    expect(find.text('Sample Seller'), findsOneWidget);

    expect(find.byIcon(Icons.add_shopping_cart_rounded), findsOneWidget);
  });
}
