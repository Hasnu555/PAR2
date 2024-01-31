import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:derviza_app/model/crops.dart';

class CustomBarChart extends StatelessWidget {
  final List<Crops> crops;

  CustomBarChart({required this.crops});

  @override
  Widget build(BuildContext context) {
    
    // Group crops by country
    Map<String, List<Crops>> cropsByCountry = {};
    crops.forEach((crop) {
      if (!cropsByCountry.containsKey(crop.country)) {
        cropsByCountry[crop.country] = [];
      }
      cropsByCountry[crop.country]!.add(crop);
    });

    // Create a series for each country
    List<ChartSeries<Crops, String>> seriesList = cropsByCountry.entries.map((entry) {
      String country = entry.key;
      List<Crops> countryCrops = entry.value;
      return BarSeries<Crops, String>(
        dataSource: countryCrops,
        xValueMapper: (Crops crop, _) => crop.country,
        yValueMapper: (Crops crop, _) => crop.quantity,
        color: Color(0xFFFAD382),
        name: country,
      );
    }).toList();

    return SfCartesianChart(
      primaryXAxis: CategoryAxis(
        // Your settings for the CategoryAxis
        labelStyle: TextStyle(fontSize: 10, color: Colors.white),
        title: AxisTitle(text: 'Country', textStyle: TextStyle(fontSize: 12, color: Colors.white)),
      ),
      primaryYAxis: NumericAxis(
        // Your settings for the NumericAxis
        labelStyle: TextStyle(fontSize: 10, color: Colors.white),
        title: AxisTitle(text: 'Quantity', textStyle: TextStyle(fontSize: 12, color: Colors.white)),
      ),
      series: seriesList,
      title: ChartTitle(
        text: 'Global Crop Imports by Country',
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }
}
