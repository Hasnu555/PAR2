import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  final String selectedFilter;
  final Function(String) onFilterSelected;

  FilterButtons({required this.selectedFilter, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          FilterButton(
              label: 'Cotton',
              isSelected: selectedFilter == 'Cotton',
              onPressed: () => onFilterSelected('Cotton')),
          FilterButton(
              label: 'Pulses',
              isSelected: selectedFilter == 'Pulses',
              onPressed: () => onFilterSelected('Pulses')),
          // Add more FilterButtons dynamically based on your data.
        ],
      ),
    );
  }
}

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function onPressed;

  FilterButton(
      {required this.label, required this.isSelected, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => onPressed(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              isSelected ? Color(0XFFFAD382) : Color(0xFF155751)),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.black : Colors.white),
        ),
      ),
    );
  }
}
