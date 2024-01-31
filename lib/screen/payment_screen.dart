import 'package:derviza_app/bloc/cart/cart_bloc.dart';
import 'package:derviza_app/bloc/cart/crop_event.dart';
import 'package:derviza_app/bloc/cart/crop_state.dart';
import 'package:derviza_app/bloc/wallet/wallet_bloc.dart';
import 'package:derviza_app/bloc/wallet/wallet_event.dart';
import 'package:derviza_app/screen/receipt_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  bool _payWithCash = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF598216),
        title: Text('Payment'),
        centerTitle: true,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoadedState) {
            return body(state);
          } else {
            return Center(
              child: Text(  'Error loading cart'),
            );
          }
        },
      ),
      );
  }

  Widget body(CartLoadedState state){
    final cart = state.cart;
       double total = 0.0;

    for (var item in cart.items) {
      total += item.product.price;
    }
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Name',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      TextFormField(
                        controller: _addressController,
                        decoration: InputDecoration(
                          labelText: 'Address',
                        ),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      SwitchListTile(
                        title: Text("Pay with Wallet"),
                        value: _payWithCash,
                        activeColor: Color(0xFF598216),
                        onChanged: (bool value) {
                          setState(() {
                            _payWithCash = value;
                          });
                        },
                      ),
                      if (!_payWithCash) ...[
                        TextFormField(
                          controller: _cardNumberController,
                          decoration: InputDecoration(
                            labelText: 'Card Number',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card number';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _expiryDateController,
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card\'s expiry date';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),
                        TextFormField(
                          controller: _cvvController,
                          decoration: InputDecoration(
                            labelText: 'CVV',
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your card\'s CVV';
                            }
                            return null;
                          },
                        ),
                      ],
                      SizedBox(height: 20),
                     
                    ],
                  ),
                ),
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Color(0xFF598216),
                    fixedSize: Size(200, 50)
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                       for (var item in cart.items) {
                        context
                            .read<CartBloc>()
                            .add(RemoveFromCartEvent(product: item.product));
                      }

                      context.read<WalletBloc>().add(MakePaymentEvent(amount: total));
                      // Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Payment Successful'),
                          duration: Duration(seconds: 2), 
                        ),
                      );
                      Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => ReceiptPage(
      name: _nameController.text,
      email: _emailController.text,
      address: _addressController.text, // You need to add this controller in PaymentPage
      cart: cart,
    ),
  ),
); 
                    }
                  },
                  child: Text(_payWithCash ? 'Confirm Payment' : 'Confirm Payment'),
                ),
              ),
            ],
          ),
        ),
      );
    
  }
}
