import 'package:derviza_app/widgets/Charts/ColumnChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:derviza_app/model/crops.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  testWidgets('CustomColumnChart Widget Test', (WidgetTester tester) async {
    // Create a list of sample crops data for testing
    List<Crops> testCrops = [
      Crops(commodity: 'Corn', index: 1, quantity: 100, country: 'USA', date: DateTime.now()),
      Crops(commodity: 'Wheat', index: 2, quantity: 150, country: 'Mexico', date: DateTime.now()),
      Crops(commodity: 'Rice', index: 3, quantity: 200, country: 'Australia', date: DateTime.now()),
    ];

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: CustomColumnChart(crops: testCrops),
      ),
    );

    // Verify that the chart title is displayed
    expect(find.text('Crop Imports by Country'), findsOneWidget);

    // Verify that the SfCartesianChart widget is present
    expect(find.byType(SfCartesianChart), findsOneWidget);

    // You can add more specific tests here based on your requirements
  });
}
