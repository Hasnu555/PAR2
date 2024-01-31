import 'package:derviza_app/screen/sidebar.dart';
import 'package:derviza_app/repository/product_repo.dart';
import 'package:derviza_app/model/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:derviza_app/bloc/product/product_bloc.dart';
import 'package:derviza_app/bloc/product/product_event.dart';
import 'package:derviza_app/bloc/product/product_state.dart';
import 'package:derviza_app/widgets/productcard.dart';

class ProductListPage extends StatefulWidget {
  @override
  _ProductListPageState createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 241, 228),
      drawer: NavBar(),
      appBar: AppBar(
        backgroundColor: Color(0xFF598216),
        title: Text('Products'),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (context) => ProductBloc(ProductFirestoreService())..add(LoadProduct()),
        child: BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF598216)), // Change the color here
                ),
              );
            } else if (state is ProductError) {
              return Center(
                child: Text('Error: ${state.errorMessage}'),
              );
            } else if (state is ProductLoaded) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text('No products found.'),
                );
              } else {
                List<Product> displayedProducts = state.products;

                // Filter products based on the search query
                if (_searchController.text.isNotEmpty) {
                  final String query = _searchController.text.toLowerCase();
                  displayedProducts = state.products
                      .where((product) =>
                          product.crop.toLowerCase().contains(query) ||
                          product.description.toLowerCase().contains(query) ||
                          product.seller.toLowerCase().contains(query))
                      .toList();
                }

                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0), // Rounded corners here
                        child: Container(
                          color: Colors.white,
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              labelText: 'Search',
                              suffixIcon: IconButton(
                                icon: Icon(Icons.clear),
                                onPressed: () {
                                  setState(() {
                                    _searchController.clear();
                                  });
                                },
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: displayedProducts.length,
                        itemBuilder: (context, index) {
                          Product product = displayedProducts[index];
                          return ProductCard(product: product);
                        },
                      ),
                    ),
                  ],
                );
              }
            } else {
              return Center(
                child: Text('Unknown state.'),
              );
            }
          },
        ),
      ),
    );
  }
}
