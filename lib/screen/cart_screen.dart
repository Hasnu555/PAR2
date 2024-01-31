import 'package:derviza_app/screen/payment_screen.dart';
import 'package:derviza_app/screen/sidebar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/bloc/wallet/wallet_bloc.dart';
import 'package:derviza_app/bloc/wallet/wallet_event.dart';
import 'package:derviza_app/model/cart.dart';
import 'package:derviza_app/bloc/cart/cart_bloc.dart';
import 'package:derviza_app/bloc/cart/crop_event.dart';
import 'package:derviza_app/bloc/cart/crop_state.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(LoadCartEvent());

    return Scaffold(
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoadingState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is CartLoadedState) {
            return _buildCartList(context, state);
          } else {
            return Center(
              child: Text(  'Error loading cart'),
            );
          }
        },
      ),
      drawer: NavBar(),
      
      appBar: AppBar
      (
        backgroundColor: Color(0xFF598216),
        title: Text('Cart'),
        centerTitle: true,
      )
    );
  }

  Widget _buildCartList(BuildContext context, CartLoadedState state) {
    final cart = state.cart;

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: cart.items.length,
            itemBuilder: (context, index) {
              final cartItem = cart.items[index];

              return ProductCartItem(
                cartItem: cartItem,
                onRemove: () {
                  context
                      .read<CartBloc>()
                      .add(RemoveFromCartEvent(product: cartItem.product));
                },
              );
            },
          ),
        ),
        _buildTotalSection(context, cart), 
      ],
    );
  }

  Widget _buildTotalSection(BuildContext context, Cart cart) {
    double total = 0.0;

    for (var item in cart.items) {
      total += item.product.price;
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total:',
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
              Text(
                '\$$total', 
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.green,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if(cart.items.length == 0)
              {
                 ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Please add items to cart'),
                          duration: Duration(seconds: 2), 
                        ),
                      );
              }
              else{
                Navigator.pushNamed(context,
                  "/payment");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF819a20),
            ),
            child: Text(
              'Pay',
              style: TextStyle(
                color: Color.fromARGB(242, 0, 31, 1),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ProductCartItem extends StatelessWidget {
  final CartItem cartItem;
  final VoidCallback onRemove;

  ProductCartItem({required this.cartItem, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0), // Add topRight border radius
          bottomLeft: Radius.circular(25.0),
          bottomRight: Radius.circular(25.0),
        ),
      ),
      color: Colors.white,
      elevation: 8.0, // Add a shadow with elevation
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25.0),
                bottomLeft: Radius.circular(25.0),
              ),
              child: Container(
                height: MediaQuery.of(context).size.height * 0.12,
                child: Image.network(
                  cartItem.product
                      .imagesUrl[0], // Use the first image for simplicity
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: ListTile(
                title: Text(
                  '${cartItem.product.crop}',
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Color(0xFF598216),
                  ),
                ),
                subtitle: Text(
                  'Seller: ${cartItem.product.seller} \nPrice: ${cartItem.product.price}',
                  style: TextStyle(
                    fontSize: 10.0,
                    fontStyle: FontStyle.italic,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: Icon(IconData(0x2716,
                        fontFamily: 'MaterialIcons')), //Icons.remove),
                    onPressed: onRemove,
                    color: Colors.red,
                    iconSize: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
  