import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:derviza_app/model/crops.dart';

class CustomColumnChart extends StatelessWidget {
  final List<Crops> crops;

  CustomColumnChart({required this.crops});

  @override
  Widget build(BuildContext context) {
    // Group crops by country and sum the quantities
    Map<String, double> totalQuantityByCountry = {};
    crops.forEach((crop) {
      totalQuantityByCountry[crop.country] = (totalQuantityByCountry[crop.country] ?? 0) + crop.quantity;
    });

    // Create a map of colors for each country
    Map<String, Color> countryColors = {
      'USA': Color(0xFF598216),
      'Mexico': Color(0xFF819a20),
      'Australia': Color(0xFF416422),
      'Zimbabwe': Color(0xFFd9d40c),
      'India': Color(0xFF72a06a),
      // Add more countries and colors as needed
    };

    // Create a series for each country with custom colors
    List<ChartSeries<MapEntry<String, double>, String>> seriesList = [
      ColumnSeries<MapEntry<String, double>, String>(
        dataSource: totalQuantityByCountry.entries.toList(),
        xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
        yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
        pointColorMapper: (MapEntry<String, double> entry, _) {
          // Assign colors based on the country
          return countryColors[entry.key] ?? Colors.grey; // Default color for unknown countries
        },
      ),
    ];

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        // Your settings for the CategoryAxis
        labelStyle: TextStyle(fontSize: 10, color: Colors.black),
        title: AxisTitle(text: 'Country', textStyle: TextStyle(fontSize: 12, color: Colors.black)),
      ),
      primaryYAxis: NumericAxis(
        // Your settings for the NumericAxis
        labelStyle: TextStyle(fontSize: 10, color: Colors.black),
        title: AxisTitle(text: 'Quantity', textStyle: TextStyle(fontSize: 12, color: Colors.black)),
      ),
      series: seriesList,
      title: ChartTitle(
        text: 'Crop Imports by Country',
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
