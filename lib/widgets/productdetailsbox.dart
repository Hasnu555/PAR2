import 'package:derviza_app/model/product.dart';
import 'package:derviza_app/model/productchartdata.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProductDetailsDialog extends StatelessWidget {
  final Product product;

  ProductDetailsDialog({required this.product});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.center,
        child: Text('Crop Health')),
      backgroundColor: Color.fromARGB(255, 211, 238, 167),
      content: Container(
        height: MediaQuery.of(context).size.height * 0.3,
        width: MediaQuery.of(context).size.width * 0.95,
        child: SfCartesianChart(
          plotAreaBackgroundColor: Color(0xFFE8F4F2), // Set the desired color here
          primaryXAxis: CategoryAxis(
            labelStyle: TextStyle(fontSize: 10, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          primaryYAxis: NumericAxis(
            labelStyle: TextStyle(fontSize: 15, color: Colors.black),
          ),
          series: <ChartSeries>[
            ColumnSeries<ProductChartData, String>(
              dataSource: [
                ProductChartData(
                    'Temperature', product.temperatureRange.toDouble()),
                ProductChartData('Moisture', product.moistureLevels.toDouble()),
                ProductChartData(
                    'Sunlight', product.sunlightExposure.toDouble()),
              ],
              xValueMapper: (ProductChartData data, _) => data.parameter,
              yValueMapper: (ProductChartData data, _) => data.value,
              pointColorMapper: (ProductChartData data, _) {
                final List<Color> colors = [
                  Color(0xFF416422),
                  Color(0xFF416422),
                  Color(0xFF416422),
                ];
                if (data.parameter == 'Temperature') {
                  return colors[0];
                } else if (data.parameter == 'Moisture') {
                  return colors[1];
                } else if (data.parameter == 'Sunlight') {
                  return colors[2];
                } else {
                  return Colors.white;
                }
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Close',style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}
