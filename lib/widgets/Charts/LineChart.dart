import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:derviza_app/model/crops.dart';

class CustomLineChart extends StatelessWidget {
  final List<Crops> crops;

  CustomLineChart({required this.crops});

  @override
  Widget build(BuildContext context) {
    // Group crops by commodity and date
    Map<String, List<MapEntry<DateTime, int>>> cumulativeDataByCommodity = {};
    crops.forEach((crop) {
      if (!cumulativeDataByCommodity.containsKey(crop.commodity)) {
        cumulativeDataByCommodity[crop.commodity] = [];
      }
      cumulativeDataByCommodity[crop.commodity]!.add(MapEntry(crop.date, crop.quantity));
    });

    // Sort the data for each commodity based on the DateTime
    cumulativeDataByCommodity.forEach((commodity, commodityData) {
      commodityData.sort((a, b) => a.key.compareTo(b.key));
    });

    // Create a map of colors for each commodity
    Map<String, Color> commodityColors = {
      'Rice': Color(0xFF598216),
      'Soyabean': Color(0xFF819a20),
      'Wheat': Color(0xFF416422),
      'Cotton': Color(0xFFd9d40c),
      'Sugar': Color(0xFF72a06a),
      // Add more commodities and colors as needed
    };

    // Create a series list for each commodity with custom colors
    List<ChartSeries<MapEntry<DateTime, int>, DateTime>> seriesList = cumulativeDataByCommodity.entries
        .map((entry) {
          String commodity = entry.key;
          List<MapEntry<DateTime, int>> commodityData = entry.value;

          if (commodityData.isEmpty) {
            // Print a message if the data is empty
            print('Data is empty for commodity: $commodity');
          }

          return LineSeries<MapEntry<DateTime, int>, DateTime>(
            dataSource: commodityData,
            xValueMapper: (entry, _) => entry.key,
            yValueMapper: (entry, _) => entry.value,
            name: commodity, // This will be displayed in the legend
            color: commodityColors[commodity] ?? Colors.grey, // Default color for unknown commodities
            markerSettings: MarkerSettings(isVisible: false),
          );
        })
        .toList();

    return SfCartesianChart(
      primaryXAxis: DateTimeAxis(
        // Customize the interval and labelStyle as needed
        interval: 0.9, // Set the interval to 1 for each date to be displayed
        labelStyle: TextStyle(fontSize: 10, color: Colors.black),
        title: AxisTitle(text: 'Date', textStyle: TextStyle(fontSize: 12, color: Colors.black)),
      ),
      primaryYAxis: NumericAxis(
        labelStyle: TextStyle(fontSize: 10, color: Colors.black),
        title: AxisTitle(text: 'Quantity', textStyle: TextStyle(fontSize: 12, color: Colors.black)),
      ),
      series: seriesList,
      title: ChartTitle(
        text: 'Time Series Chart',
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      ),
      legend: Legend(
        isVisible: true,
        position: LegendPosition.top, // Adjust position as needed
        textStyle: TextStyle(fontSize: 12, color: Colors.black),
      ),
    );
  }
}
