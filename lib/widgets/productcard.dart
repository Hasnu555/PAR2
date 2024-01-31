import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:derviza_app/bloc/cart/crop_event.dart';
import 'package:derviza_app/bloc/cart/crop_state.dart';
import 'package:derviza_app/screen/product_screen.dart';
import 'package:derviza_app/screen/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/bloc/cart/cart_bloc.dart';
import 'package:derviza_app/widgets/productdetailsbox.dart';
import 'package:derviza_app/model/product.dart';

class ProductCard extends StatefulWidget {
  final Product product;

  ProductCard({required this.product});

  @override
  _ProductCardState createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startImageSlideshow();
  }

  void _startImageSlideshow() {
    const int slideDuration = 3; // Duration between image changes in seconds

    _timer = Timer.periodic(Duration(seconds: slideDuration), (timer) {
      if (_currentPage < widget.product.imagesUrl.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _showProductDetails() {
    showDialog(
      context: context,
      builder: (BuildContext context) =>
          ProductDetailsDialog(product: widget.product),
    );
  }

  void _addToCart(BuildContext context, Product product) {
    context.read<CartBloc>()..add(AddToCartEvent(product: product));

    // Display a SnackBar to show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Color(0xFF819a20),
        content: Text('${product.crop} added to cart'),
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          backgroundColor: Color(0xFF416422),
          onPressed: () {
            Navigator.pushNamed(
              context,
              "/cart",
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: Colors.white,
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
                height: MediaQuery.of(context).size.height * 0.22,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: widget.product.imagesUrl.length,
                  itemBuilder: (context, index) {
                    // return CachedNetworkImage(
                    //   imageUrl: widget.product.imagesUrl[index],
                    // );

                    return Image.network(
                      widget.product.imagesUrl[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    title: Text(
                      '${widget.product.crop}',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Color(0xFF598216),
                      ),
                    ),
                    subtitle: Text(
                      '${widget.product.description.length > 85 ? widget.product.description.substring(0, 85) + "..." : widget.product.description}',
                      style: TextStyle(
                        fontSize: 10.0,
                        fontStyle: FontStyle.italic,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.price_change_rounded,
                              color: Color(0xFF598216),
                              size: 18.0,
                            ),
                            Text(
                              ' ${widget.product.price}',
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Color(0xFF598216),
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Text(
                        //       '${widget.product.seller}',
                        //       style: TextStyle(
                        //         fontSize: 10.0,
                        //         color: Colors.black87,
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                  
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: _showProductDetails,
                              icon: Icon(
                                Icons.bar_chart_sharp,
                                color: Color(0xFFd9d40c),
                              ),
                            ),
                            BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                              return IconButton(
                                onPressed: () {
                                  _addToCart(context, widget.product);
                                },
                                icon: Icon(
                                  Icons.add_shopping_cart_rounded,
                                  color: Color(0xFF416422),
                                  size: 18,
                                ),
                              );
                            }
                            ),
                            IconButton(onPressed: (){
                              Navigator.pushNamed(
                                context, 
                                '/productPage', 
                                arguments: widget.product,
                              );
                            }
                            , icon: Icon(Icons.remove_red_eye_sharp)
                            )
                            
                          ],
                        ),
                        
                      ],
                    ),
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
