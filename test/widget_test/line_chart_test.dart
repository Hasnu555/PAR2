import 'package:derviza_app/widgets/Charts/LineChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:derviza_app/model/crops.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  testWidgets('CustomLineChart Widget Test', (WidgetTester tester) async {
    // Create a list of sample crops data for testing
    List<Crops> testCrops = [
      Crops(commodity: 'Rice', index: 1, quantity: 100, country: 'USA', date: DateTime.now()),
      Crops(commodity: 'Rice', index: 2, quantity: 150, country: 'USA', date: DateTime.now()),
      Crops(commodity: 'Wheat', index: 3, quantity: 200, country: 'Mexico', date: DateTime.now()),
    ];

    // Build our widget and trigger a frame
    await tester.pumpWidget(
      MaterialApp(
        home: CustomLineChart(crops: testCrops),
      ),
    );

    // Verify that the chart title is displayed
    expect(find.text('Time Series Chart'), findsOneWidget);

    // Verify that the SfCartesianChart widget is present
    expect(find.byType(SfCartesianChart), findsOneWidget);

    // You can add more specific tests here based on your requirements
  });
}
