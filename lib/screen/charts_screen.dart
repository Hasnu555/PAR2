import 'package:derviza_app/widgets/adwidget.dart';
import 'package:derviza_app/screen/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/bloc/crops/crops_bloc.dart';
import 'package:derviza_app/bloc/crops/crops_event.dart';
import 'package:derviza_app/widgets/Charts/ColumnChart.dart';
import 'package:derviza_app/widgets/Charts/LineChart.dart';
import 'package:derviza_app/widgets/Charts/PieChart.dart';
import 'package:derviza_app/model/crops.dart';

class ChartDisplay extends StatefulWidget {
  @override
  _ChartDisplayState createState() => _ChartDisplayState();
}

class _ChartDisplayState extends State<ChartDisplay> {
  String? selectedCommodity;
  String? selectedCountry;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CropsBloc>(context).add(LoadCrops());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CropsBloc, CropsState>(
      builder: (context, state) {
        if (state is CropsLoading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF598216)), // Change the color here
            ),
          );
        
        } else if (state is CropsError) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else if (state is CropsLoaded) {
          return _buildChartDisplay(state.crops);
        } else {
          return Center(child: Text('No data available.'));
        }
      },
    );
  }

  Widget _buildChartDisplay(List<Crops> cropsData) {
    return Scaffold(
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color(0xFF598216),
        title: Text('Charts'),
        centerTitle: true,
      ),
      backgroundColor: Color.fromARGB(255, 236, 241, 228),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              padding: EdgeInsets.all(15.0),
              child: AdWidget(
                imageUrl: "https://videohive.img.customer.envatousercontent.com/files/302647951/Agriculture%20Farming%20Business%201920x1080.jpg?auto=compress%2Cformat&fit=crop&crop=top&max-h=8000&max-w=590&s=fad175506a2b31368ffcf1d06ec2926c", 
                adLink: "https://www.freepik.com/free-photos-vectors/farm-banner"
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: CustomPieChart(crops: _getFilteredCropsData(cropsData)),
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: CustomLineChart(crops: _getFilteredCropsData(cropsData)),
              ),
            ),
            Container(
              height: 250,
              padding: EdgeInsets.all(15.0),
              child: Container(
                padding: EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child:
                    CustomColumnChart(crops: _getFilteredCropsData(cropsData)),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF819a20),  
        onPressed: () {
          _showFilterDialog(cropsData);
        },
        tooltip: 'Filter',
        child: Icon(Icons.filter_list),
      ),
    );
  }

  void _showFilterDialog(List<Crops> cropsData) {
    Set<String> uniqueCommodities = cropsData.map((crops) => crops.commodity).toSet();
    Set<String> uniqueCountries = cropsData.map((crops) => crops.country).toSet();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(
            child: Text('Filter'),
          ),
          backgroundColor: Color.fromARGB(255, 211, 238, 167),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButton<String>(
                value: selectedCommodity,
                hint: Text('Select Commodity'),
                onChanged: (String? value) {
                  setState(() {
                    selectedCommodity = value;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'All',
                    child: Text('All'),
                  ),
                  ...uniqueCommodities
                      .map((commodity) => DropdownMenuItem<String>(
                            value: commodity,
                            child: Text(commodity),
                          ))
                      .toList(),
                ],
                dropdownColor: Color(0xFF819a20),
              ),
              DropdownButton<String>(
                value: selectedCountry,
                hint: Text('Select Country'),
                onChanged: (String? value) {
                  setState(() {
                    selectedCountry = value;
                  });
                },
                items: [
                  DropdownMenuItem<String>(
                    value: 'All',
                    child: Text('All'),
                  ),
                  ...uniqueCountries
                      .map((country) => DropdownMenuItem<String>(
                            value: country,
                            child: Text(country),
                          ))
                      .toList(),
                ],
                dropdownColor: Color(0xFF819a20),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF598216), 
              ),
            ),
            TextButton(
              onPressed: () {
                // Refresh data based on filters
                BlocProvider.of<CropsBloc>(context).add(LoadCrops());
                Navigator.of(context).pop();
              },
              child: Text('Apply'),
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Color(0xFF598216),
              ),
            ),
          ],
        );
      },
    );
  }

  List<Crops> _getFilteredCropsData(List<Crops> cropsData) {
    return cropsData
        .where((crops) =>
            (selectedCommodity == null || selectedCommodity == 'All' ||
                crops.commodity == selectedCommodity) &&
            (selectedCountry == null || selectedCountry == 'All' ||
                crops.country == selectedCountry))
        .toList();
  }
}
