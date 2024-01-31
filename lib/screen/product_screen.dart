import 'package:derviza_app/bloc/cart/cart_bloc.dart';
import 'package:derviza_app/bloc/cart/crop_event.dart';
import 'package:derviza_app/bloc/cart/crop_state.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:derviza_app/model/product.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> with TickerProviderStateMixin {
  int _currentImageIndex = 0;
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
    return Scaffold(
      backgroundColor: Colors.white, // Match the background color
      appBar: AppBar(
        // AppBar details if needed
      ),
      body: SingleChildScrollView(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildImageCarousel(widget.product.imagesUrl),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.product.crop,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '\$${widget.product.price}',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.green,
                          ),
                        ),
                        RatingBarIndicator(
                          rating: widget.product.ratings, // Replace with the actual rating
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Colors.amber,
                          ),
                          itemCount: 5,
                          itemSize: 20.0,
                          direction: Axis.horizontal,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Row(
                      children: <Widget>[
                        
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              widget.product.seller, // Replace with seller's name
                              style: TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    Text(
                      widget.product.description,
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    SizedBox(height: 24),
                    BlocBuilder<CartBloc, CartState>(
                                builder: (context, state) {
                              return ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF598216), // Background color
                        foregroundColor: Colors.white, // Text Color (Foreground color)
                      ),
                      onPressed: () {
                         _addToCart(context, widget.product);
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Center(child: Text('Add to Cart')),
                      ),
                    );
                            }
                            ),
                    
                    
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildImageCarousel(List<String> imagesUrl) {
    return CarouselSlider(
      options: CarouselOptions(
        autoPlay: false,
        enlargeCenterPage: true,
        onPageChanged: (index, reason) {
          setState(() {
            _currentImageIndex = index;
          });
        },
      ),
      items: imagesUrl.map((url) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(url, fit: BoxFit.cover),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
