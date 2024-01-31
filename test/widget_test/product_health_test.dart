import 'package:derviza_app/widgets/productdetailsbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:derviza_app/model/product.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  testWidgets('ProductDetailsDialog Widget Test', (WidgetTester tester) async {
    // Create a sample Product for testing
    Product testProduct = Product(
      index: '1',
      crop: 'Rice',
      description: 'Sample description',
      price: 100,
      temperatureRange: 25,
      moistureLevels: 60,
      sunlightExposure: 8,
      ratings: 3,
      seller: 'Sample Seller',
      imagesUrl: ['image_url_1', 'image_url_2'],
    );

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: ProductDetailsDialog(product: testProduct),
      ),
    );

    // Verify that the dialog title is displayed
    expect(find.text('Crop Health'), findsOneWidget);

    // Verify that the chart is displayed
    expect(find.byType(SfCartesianChart), findsOneWidget);

    // You can add more specific tests here based on your requirements

    // For example, to test if the "Close" button is present:
    expect(find.text('Close'), findsOneWidget);
  });
}
