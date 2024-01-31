import 'package:derviza_app/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:derviza_app/model/cart.dart';

class ReceiptPage extends StatelessWidget {
  final String name;
  final String email;
  final String address;
  final Cart cart;

  const ReceiptPage({
    Key? key,
    required this.name,
    required this.email,
    required this.address,
    required this.cart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double total = 0.0;
    cart.items.forEach((item) {
      total += item.product.price;
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Receipt'),
        backgroundColor: Color(0xFF598216),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: Color(0xFF598216), size: 40),
                    Text('Payment Successful!', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF598216))),
                    SizedBox(height: 16),
                    Text('Thank you, $name!', style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
              
              SizedBox(height: 16),
              Text('Email: $email', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text('Address: $address', style: TextStyle(fontSize: 16)),
              SizedBox(height: 16),
              Divider(),
              Text('Cart Items:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 8),
              SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Card(
                      child: ListTile(
                        title: Text(item.product.crop),
                        trailing: Text('\$${item.product.price}'),
                      ),
                    );
                  },// Add this line to make the ListView scrollable
                ),
              ),
              Divider(),
              Text('Total: \$${total.toStringAsFixed(2)}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Home();
                  },
                  child: Text('Continue Shopping',style: TextStyle(color: Colors.black),),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
