import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:derviza_app/model/crops.dart';

class CustomPieChart extends StatelessWidget {
  final List<Crops> crops;

  CustomPieChart({required this.crops});

  @override
  Widget build(BuildContext context) {
    // Group the crops data by country and sum the quantities
    Map<String, double> countryQuantities = {};
    for (Crops crop in crops) {
      countryQuantities[crop.country] = (countryQuantities[crop.country] ?? 0) + crop.quantity;
    }

    // Create a map of colors for each country
    Map<String, Color> countryColors = {
      'USA': Color(0xFF598216),
      'Mexico': Color(0xFF819a20),
      'Australia': Color(0xFF416422),
      'Zimbabwe': Color(0xFFd9d40c),
      'India': Color(0xFF72a06a),
      // Add more countries and colors as needed
    };

    // Create a series for the pie chart with custom colors based on the country
    List<PieSeries<MapEntry<String, double>, String>> seriesList = [
      PieSeries<MapEntry<String, double>, String>(
        dataSource: countryQuantities.entries.toList(),
        xValueMapper: (MapEntry<String, double> entry, _) => entry.key,
        yValueMapper: (MapEntry<String, double> entry, _) => entry.value,
        dataLabelMapper: (MapEntry<String, double> entry, _) => '${entry.key}: ${entry.value}',
        pointColorMapper: (MapEntry<String, double> entry, _) {
          // Assign colors based on the country
          return countryColors[entry.key] ?? Colors.grey; // Default color for unknown countries
        },
      ),
    ];

    return SfCircularChart(
      series: seriesList,
      legend: Legend(
        isVisible: true,
        position: LegendPosition.right,
        textStyle: TextStyle(fontSize: 12, color: Colors.black),
      ),
      title: ChartTitle(
        text: 'Global Crop Distribution by Country',
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
    );
  }
}
