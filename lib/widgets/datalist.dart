import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataListView extends StatelessWidget {
  final String selectedCommodity;
  final String selectedCountry;
  final String selectedMonth;

  final Map<String, IconData> commodityIcons = {
    'Cotton': Icons.fiber_manual_record, // or any cotton-related icon
    'Rice': Icons.local_dining,
    'Wheat': Icons.grass,
    'Soyabean': Icons.eco,
    'Pulses': Icons.grain,
    // Add more commodities and their corresponding icons
  };

  DataListView({
    required this.selectedCommodity,
    required this.selectedCountry,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot?>(
      stream: FirebaseFirestore.instance.collection("test2").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        final data = snapshot.data?.docs;
        if (data == null || data.isEmpty) {
          return Text('No data available');
        }

        final filteredData = filterData(data);

        return ListView.builder(
          itemCount: filteredData.length,
          itemBuilder: (context, index) {
            final doc = filteredData[index];
            final commodity = doc['Commodity'];
            final country = doc['Country'];
            final month = doc['Month'];
            final quantity = doc['Quantity'];
            final year = doc['Year'];

            final IconData commodityIcon =
                commodityIcons[commodity] ?? Icons.agriculture_rounded;

            return Card(
              elevation: 4,
              margin: EdgeInsets.all(8),
              child: ListTile(
                leading: Icon(
                  commodityIcon,
                  size: 36,
                  color: Colors.yellow[700],
                ),
                title: Text(
                  'Commodity: $commodity',
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Country: $country'),
                    Text('Month: $month'),
                    Text('Quantity: $quantity'),
                    Text('Year: $year'),
                  ],
                ),
                trailing: IconButton(
                  icon: Icon(Icons.favorite_border, color: Colors.red),
                  onPressed: () {
                    // Implement your favorite button functionality here.
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  List<DocumentSnapshot> filterData(List<QueryDocumentSnapshot>? data) {
    if (data == null) {
      return [];
    }

    return data.where((doc) {
      final commodityMatches = selectedCommodity == 'All' || doc['Commodity'] == selectedCommodity;
      final countryMatches = selectedCountry == 'All' || doc['Country'] == selectedCountry;
      final monthMatches = selectedMonth == 'All' || doc['Month'] == selectedMonth;

      return commodityMatches && countryMatches && monthMatches;
    }).toList();
  }
}
