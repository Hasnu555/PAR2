import 'package:flutter/material.dart';

class DataInputFormDialog extends StatefulWidget {
  final Function(String, String, String, String, String) onSave;

  DataInputFormDialog({required this.onSave});

  @override
  _DataInputFormDialogState createState() => _DataInputFormDialogState();
}

class _DataInputFormDialogState extends State<DataInputFormDialog> {
  final TextEditingController commodityController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController monthController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Data'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildTextField(commodityController, 'Commodity'),
            _buildTextField(countryController, 'Country'),
            _buildTextField(monthController, 'Month'),
            _buildTextField(quantityController, 'Quantity'),
            _buildTextField(yearController, 'Year'),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            // Pass the data to the callback function for saving.
            widget.onSave(
              commodityController.text,
              countryController.text,
              monthController.text,
              quantityController.text,
              yearController.text,
            );
            Navigator.of(context).pop(); // Close the dialog.
          },
          child: Text('Save'),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog.
          },
          child: Text('Cancel'),
        ),
      ],
    );
  }

  Widget _buildTextField(TextEditingController controller, String labelText) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
        ),
      ),
    );
  }
}
